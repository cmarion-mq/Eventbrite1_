class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    redirect_to new_user_session_path unless user_signed_in?
    @event = Event.new
  end

  def create
    @event = Event.new(
      title: params[:title],
      location: params[:location],
      start_date: params[:start_date],
      duration: params[:duration],
      price: params[:price].to_i,
      description: params[:description],
      administrator: current_user
      )

    if @event.save
      redirect_to root_path
    else
      render :new
    end
  end
end
