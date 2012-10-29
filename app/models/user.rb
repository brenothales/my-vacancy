class User < ActiveRecord::Base
  belongs_to :role
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :phone, :email, :password, :password_confirmation, :remember_me, :role_id, :situation
  # attr_accessible :title, :body
  
  def is_role?(role)
    self.role.name.to_sym.eql?(role)
  end

  with_options :presence => true do |validation|
    validation.with_options :uniqueness => true do |validation|
      validation.validates :name
      validation.validates :email
    end
    validation.validates :password
    validation.validates :role_id
  end
    
  validates_confirmation_of :password
  after_create :notification_user

protected
  
  def notification_user
    NotificationMailer.notify_new_account(self).deliver
  end

end
