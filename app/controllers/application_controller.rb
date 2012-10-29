class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json, :js
  
private

  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource_or_scope)
    admin_root_path
  end




end
