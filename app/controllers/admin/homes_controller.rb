#coding : utf-8
class Admin::HomesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    if current_user.is_role? :administrador
      @msg = 'batata'
    elsif current_user.is_role? :moderador
      @announcements_size = Announcement.announcements_by_user(current_user).count
      @has_new_comments   = Comment.has_new_comments(current_user)
    end 
  end
  
end
