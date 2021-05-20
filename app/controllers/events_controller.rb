class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    redirect_to root_path unless user_signed_in?
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
      p @event.errors.messages
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    #before_action @event.administrator?(current_user)
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(title: params[:title],
      location: params[:location],
      start_date: params[:start_date],
      duration: params[:duration],
      price: params[:price].to_i,
      description: params[:description],
      administrator: current_user
      )
      redirect_to @event, flash: { success: 'Evénement mis à jour !' }
    else
      render :edit
    end
  end
end
