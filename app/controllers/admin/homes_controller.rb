#coding : utf-8
class Admin::HomesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    if current_user.is_role? :administrador
      #ultimos 5 anuncios
      #ultimos 5 usuarios
    elsif current_user.is_role? :moderador
      @announcements_size = Announcement.announcements_by_user(current_user).count 
    end 
  end
  
end
