class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    creator = User.find(session[:current_user]['id'])
    @event = creator.created_events.build(event_params)

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

  def attend
    @event = Event.find(params[:id])

    begin
      if session[:current_user]
        attendee = User.find(session[:current_user]['id'])
        @event.attendees << attendee
        flash[:success] = 'You are now registered for this event.'
        redirect_to event_path(@event)
      else
        flash[:notice] = 'User is not signed in.'
        redirect_to root_path
      end
    rescue
      flash.now[:notice] = "You are already registered for this event."
    end
  end

  private

  def event_params
    params.require(:event).permit(:date, :description)
  end

end
