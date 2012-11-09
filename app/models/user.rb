class User < ActiveRecord::Base
  belongs_to :role
  has_many :announcements
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
      validation.validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    end
    validation.validates :password
    validation.validates :phone, :format => { :with => /\([0-9]{2}\)\s[0-9]{4}-[0-9]{4}/ }
  end
    
  validates_confirmation_of :password
  after_create :notification_user

  def self.search(search, order_by, ordem)
    unless search.nil? || search.empty?
      where('name LIKE ?',"%#{search}%").order("#{order_by} #{ordem}")
    else
      order("#{order_by} #{ordem}")
    end
  end

protected
  
  def notification_user
    NotificationMailer.notify_new_account(self).deliver
  end

end
