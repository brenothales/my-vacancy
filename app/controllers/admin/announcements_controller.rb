#coding : utf-8
class Admin::AnnouncementsController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :load_resources, :except => [:show, :destroy]
  
  def index
    @announcements = Announcement.paginate(:per_page => $per_page,:page => params[:page])
    respond_with @announcements,:location => admin_announcements_path
  end

  def show
    @announcement = Announcement.find(params[:id])
    respond_with @announcement,:location => admin_announcement_path
  end

  def new
    @announcement = Announcement.new
    respond_with @announcement, :location => new_admin_announcement_path
  end
 
  def edit
    @announcement = Announcement.find(params[:id])
  end

  def create
    @announcement = Announcement.new(params[:announcement])
    flash[:notice] = t('cruds.notifications.create', :model => "Anúncio") if @announcement.save
    respond_with @announcement,:location => new_admin_announcement_path
  end

  def update
    @announcement = Announcement.find(params[:id])
    flash[:notice] = t('cruds.notifications.update', :model => "Anúncio") if @announcement.update_attributes(params[:announcement])
    respond_with @announcement,:location => admin_announcements_path
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    flash[:notice] = t('cruds.notifications.destroy', :model => "Anúncio") if @announcement.destroy
    redirect_to admin_announcements_path
  end

  def find_cities_by_state
    @cities = City.where(:state_id => params[:state_id]) unless params[:state_id].blank?
  end

protected

  def load_resources
    @states = State.order('name ASC')
    @categories = Category.order('name ASC')  
  end

end
