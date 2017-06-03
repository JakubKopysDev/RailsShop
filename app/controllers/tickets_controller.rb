class TicketsController < ApplicationController
  def create
    @ticket = Ticket.new ticket_params

    if current_user
      @ticket.user_id = current_user.id
    end

    if @ticket.valid?
      @ticket.save
      redirect_back fallback_location: products_path, notice: 'Ticket submitted'
    else
      redirect_back fallback_location: products_path, alert: 'Invalid ticket'
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:content, :email, :name)
  end
end
