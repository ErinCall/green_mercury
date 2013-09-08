class TimeTrackingController < ApplicationController
  before_filter :require_login

  def index
    @hours = current_user.volunteer_hours
    @hours_to_go = PERK_EVERY_N_HOURS - (@hours % PERK_EVERY_N_HOURS)
    @volunteer_blocks = current_user.volunteer_blocks
  end

  def track
    volunteer_block = VolunteerBlock.new(
      params[:volunteer_block].permit(:on, :hours))
    volunteer_block.user_id = current_user.id
    if volunteer_block.valid?
      volunteer_block.save
      flash[:notice] = "You're awesome!"
      redirect_to time_tracking_path
    else
      index
      @volunteer_block = volunteer_block
      render :index
    end
  end

  def edit
    volunteer_block = VolunteerBlock.find(params[:id])
    volunteer_block.update_attributes(
      params[:volunteer_block].permit(:on, :hours))
    volunteer_block.save
    respond_to do |format|
      format.html do
        if request.xhr?
          render :text => params[:volunteer_block].values.first
        else
          redirect_to time_tracking_path
        end
      end
    end
  end
end
