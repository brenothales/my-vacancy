class NotificationMailer < ActionMailer::Base
  default :from => "from@example.com", :subject => "Sua conta foi criada com sucesso!"

  def notify_new_account(user)
    @user = user
    mail(:to => @user.email)
  end

  def notify_weekly
    users = User.actived?
    users.each { |user| mail(:to => user.email) }  
  end

end
