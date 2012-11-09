class Admin::CommentsController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!  


  def index
    @comments_unread = Comment.unread(current_user).paginate(:per_page => 5, :page => params[:page])
    @comments_read   = Comment.read(current_user).paginate(:per_page => 5, :page => params[:page])
    respond_with @comments_unread, @comments_read, :location => admin_comments_path
  end

end
