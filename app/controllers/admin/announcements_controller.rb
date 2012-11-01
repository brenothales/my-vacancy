class Admin::AnnouncementsController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!
  
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
    flash[:notice] = t('cruds.notifications.create', :model => Announcement) if @announcement.save
    respond_with @announcement,:location => new_admin_announcement_path
  end

  def update
    @announcement = Announcement.find(params[:id])
    flash[:notice] = t('cruds.notifications.update', :model => Announcement) if @announcement.update_attributes(params[:announcement])
    respond_with @announcement,:location => admin_announcements_path
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    flash[:notice] = t('cruds.notifications.destroy', :model => Announcement) if @announcement.destroy
    redirect_to admin_announcements_path
  end

end
