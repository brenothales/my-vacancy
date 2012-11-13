class Admin::CommentsController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!  
  before_filter :load_comments, :only => [:index, :update, :comments_by_situation]

  def index
    @comments  = Comment.by_announcement_by_user(current_user).search(params[:search], order_by, ordem).paginate(:per_page => 5, :page => params[:page])
    respond_with @comments, @comments_unread, @comments_read, :location => admin_comments_path
  end

  def comments_by_situation
    @comments = Comment.by_announcement_by_user(current_user).by_situation(params[:situation]).order("#{order_by} #{ordem}").paginate(:per_page => params[:per_page],:page => params[:page]) if params[:situation]
    render :action => :index
  end

  def update
    @comment = Comment.find params[:id]
    @comment.update_column(:situation, !@comment.situation)
    respond_with @comment, @comments_unread, @comments_read, :location => admin_comments_path  
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy  
  end

protected

  def load_comments
    @comments_unread = Comment.unread(current_user).search(params[:search], order_by, ordem).paginate(:per_page => 5, :page => params[:page])
    @comments_read   = Comment.read(current_user).search(params[:search], order_by, ordem).paginate(:per_page => 5, :page => params[:page])  
  end

end
