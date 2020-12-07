module EventsHelper

  def attend
    @event = Event.find(params[:id])

    begin
      if session[:current_user]
        attendee = User.find(session[:current_user]['id'])
        @event.attendees << attendee

        @invite = Invite.find_by_recipient_id(attendee.id)
        @invite.destroy 

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

  def invite_to
    @event = Event.find(invite_params[:event_id])
    @invite = @event.invites.build
    @recipient = User.find_by_username(invite_params[:username])

    @invite.sender_id = session[:current_user]['id']
    @invite.recipient_id = @recipient.id if @recipient.nil? == false

    if @invite.save
      flash[:success] = "You have invited #{@recipient.username} to the event."
      redirect_to event_path(@event)
    else
      render "events/show", :id => @event.id
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:username, :event_id)
  end

  def invited?
    event = Event.find(params[:id])
    unless event.invites.find_by_recipient_id(session[:current_user]['id'])
      flash[:notice] = "You have not been invited to this event."
      redirect_to event_path(event)
    end
  end

  #same user?

end
