class Admin::HomesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @msg = 'hello admin'
  end

end
