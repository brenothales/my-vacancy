class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json, :js
  helper_method :order_by, :ordem

  def order_by 
    model_name = controller_name.to_s.camelcase.singularize
    model_name.constantize.column_names.include?(params[:order_by]) ? params[:order_by] : 'id'  
  end
  
  def ordem
    ['ASC', 'DESC'].include?(params[:ordem]) ? params[:ordem] : 'DESC'
  end
  
private

  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource_or_scope)
    admin_root_path
  end


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_root_url, :alert => t('general.no_permission')
  end

end
