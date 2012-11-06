#coding : utf-8
class Admin::AnnouncementsController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :load_resources, :except => [:show, :destroy]
  before_filter :load_announcements_by_category, :only => [:index, :announcements_by_category]

  def index
    @announcements = Announcement.announcements_by_user(current_user).search(params[:search], order_by, ordem).paginate(:per_page => params[:per_page],:page => params[:page])
    respond_with @announcements,:location => admin_announcements_path
  end

  def show
    @announcement = Announcement.find(params[:id])
    respond_with @announcement,:location => admin_announcement_path
  end

  def new
    @announcement = current_user.announcements.build
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

  def announcements_by_category
    @announcements = Announcement.by_category(params[:category_id]).order("#{order_by} #{ordem}").paginate(:per_page => params[:per_page],:page => params[:page]) if params[:category_id]
    render :action => :index
  end

  def update_situation 
    @announcement = Announcement.find(params[:id])
    @announcement.situation = !@announcement.situation
    @announcement.save
    respond_with @announcement
  end
    
  
protected

  def load_resources
    @states = State.order('name ASC')
    @categories = Category.order('name ASC')  
  end

  def load_announcements_by_category
    @announcements_for_sale = @announcements.for_sale
    @announcements_for_rent = @announcements.for_rent
    @announcements_for_buy  = @announcements.for_buy  
  end

end
