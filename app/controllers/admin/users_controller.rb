#coding : utf-8
class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!

  def index
    if current_user.is_role?(:administrador)
      @users = User.search(params[:search], order_by, ordem).paginate(:per_page => params[:per_page],:page => params[:page])
      respond_with @users, :location => admin_users_path
    else
      redirect_to edit_admin_user_path(current_user)
    end
  end

  def show
    @user = User.find params[:id]
    respond_with @user, :location => admin_user_path 
  end

  def edit
    @user = User.find params[:id]  
  end
  
  def update
    @user = User.find(params[:id])
    flash[:notice] = t('cruds.notifications.update', :model => "Usuário") if @user.update_attributes(params[:user])
    respond_with @user,:location => admin_root_path
  end

  def update_situation 
    @user = User.find(params[:id])    
    @user.situation = @user.situation ? false : true
    @user.save
    respond_with @user
  end

end
