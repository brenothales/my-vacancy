class Admin::HomesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @msg = current_user.role.name
    @states = State.order(:name => :asc)
    @announcement  = Announcement.new
  end

end
