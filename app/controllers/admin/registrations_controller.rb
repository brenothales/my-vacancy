#coding : utf-8
class Admin::RegistrationsController < Devise::SessionsController
  layout "login"  
  
protected

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

end

