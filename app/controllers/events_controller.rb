class EventsController < ApplicationController
  include EventsHelper
  before_action :invited?
  before_action :attended?
  before_action :recipient_is_sender?
  skip_before_action :invited?, except: [:attend]
  skip_before_action :attended?, except: [:invite_to]
  skip_before_action :recipient_is_sender?, except: [:invite_to]

  def index
    @events = Event.all
    @upcoming_events = @events.upcoming_events.order(date: :asc)
    @previous_events = @events.previous_events.order(date: :desc)
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
    @event = Event.eager_load([:creator, :attendees]).find(params[:id])
    @invite = @event.invites.build
  end

  private

  def event_params
    params.require(:event).permit(:date, :description)
  end

end
