class Admin::RegistrationsController < Devise::SessionsController
  layout "login"

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = t('general.new_user')
      redirect_to new_user_session_path   
    end
  end

end

