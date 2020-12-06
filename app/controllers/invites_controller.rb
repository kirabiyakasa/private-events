class InvitesController < ApplicationController

  def create
    @invite = Invite.new
    @event = Event.find(invite_params[:event_id])
    @recipient = User.find_by_username(invite_params[:username])

    @invite.sender_id = session[:current_user]['id']
    @invite.recipient_id = @recipient.id
    @invite.event_id = @event.id

    if @invite.save
      flash[:success] = "You have invited #{@user.username} to the event."
      redirect_to event_path(@event)
    else
      flash[:notice] = 'Invalid User.'
      render "events/show", :id => @event.id
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:username, :event_id)
  end

end
