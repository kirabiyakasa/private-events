class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    user = User.find(session[:current_user]['id'])
    @event = user.created_events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path,
        notice: 'event successfully signed up.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors,
        status: :unprocessable_entity }
      end
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:date)
  end

end