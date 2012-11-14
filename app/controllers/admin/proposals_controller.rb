class Admin::ProposalsController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!  
  before_filter :load_proposals, :only => [:index, :update, :proposals_by_situation, :destroy]

  def index
    if current_user.is_role? :administrador
      @proposals = Proposal.search(params[:search], order_by, ordem).paginate(:per_page => 5, :page => params[:page])
    else
      @proposals  = Proposal.by_announcement_by_user(current_user).search(params[:search], order_by, ordem).paginate(:per_page => 5, :page => params[:page])
    end    
    respond_with @proposals, @proposals_unread, @proposals_read, :location => admin_proposals_path
  end

  def proposals_by_situation
    @proposals = Proposal.by_announcement_by_user(current_user).by_situation(params[:situation]).order("#{order_by} #{ordem}").paginate(:per_page => params[:per_page],:page => params[:page]) if params[:situation]
    render :action => :index
  end

  def update
    @proposal = Proposal.find params[:id]
    @proposal.update_column(:situation, !@proposal.situation)
    respond_with @proposals, @proposals_unread, @proposals_read, :location => admin_proposals_path  
  end

  def destroy
    @proposal = Proposal.find params[:id]
    @proposal.destroy  
  end

protected

  def load_proposals
    @proposals_unread = Proposal.unread(current_user).search(params[:search], order_by, ordem).paginate(:per_page => 5, :page => params[:page])
    @proposals_read   = Proposal.read(current_user).search(params[:search], order_by, ordem).paginate(:per_page => 5, :page => params[:page])  
  end

end
