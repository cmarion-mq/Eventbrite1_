class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
  end
  
  def new
    @event = Event.find(params[:event_id])
    @amount = @event.price
    @stripe_amount = (@amount * 100).to_i
  end

  def create
    # Before the rescue, at the beginning of the method
    @event = Event.find(params[:event_id])
    @amount = @event.price
    @stripe_amount = (@amount * 100).to_i
    
    begin
      customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @stripe_amount,
      description: "Paiement d'un évènement",
      currency: 'eur',
      })
    Attendance.create(event: @event, attendee: current_user, stripe_customer_id: customer.id)
    redirect_to event_path(@event), flash: { success: 'Merci pour ton inscription !' }

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(@event)
    end
    # After the rescue, if the payment succeeded
  end
end
