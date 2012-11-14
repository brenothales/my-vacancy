#coding : utf-8
class Admin::HomesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    if current_user.is_role? :administrador
      @announcements_last_five = Announcement.limit(5).order('id DESC')
      @users_last_five         = User.limit(5).order('id DESC')
      @proposals_last_five     = Proposal.limit(5).order('id DESC')
    elsif current_user.is_role? :moderador
      @announcements_size = Announcement.announcements_by_user(current_user).count
      @has_new_comments   = Comment.has_new_comments(current_user)
      @comments_size      = Comment.by_announcement_by_user(current_user).count
      @comments_last_five = Comment.by_announcement_by_user(current_user).limit(5).order('id DESC')
      @announcements_last_five = Announcement.announcements_by_user(current_user).limit(5).order('id DESC')
      @proposals_last_five     = Proposal.by_announcement_by_user(current_user).limit(5).order('id DESC')
      @proposals_size     = Proposal.by_announcement_by_user(current_user).count
    end 
  end
  
end
