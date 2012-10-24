class NotificationMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify_new_account(user)
    @user = user
    mail(:to => @user.email, :subject => "Sua conta foi criada com sucesso!")
  end

end
