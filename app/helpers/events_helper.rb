module EventsHelper

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

end
