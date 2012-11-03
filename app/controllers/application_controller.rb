class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json, :js

  def load_order
    $order_by = params[:order_by].nil? ? 'id' : params[:order_by]
    $ordem    = params[:ordem].nil? ? 'DESC' : params[:ordem]
    $per_page = params[:per_page].nil? ? 5 : params[:per_page]
  end
  
private

  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource_or_scope)
    admin_root_path
  end




end
