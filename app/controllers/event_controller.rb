# frozen_string_literal: true

class EventController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:id])
    @guests = @event.guests
    @start_date = @event.start_date.strftime('%d/%m/%Y à %Hh%M')
    @end_date = @event.end_date.strftime('%d/%m/%Y à %Hh%M')
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(start_date: params[:event_start_date], duration: params[:event_duration],
                       title: params[:event_title], host: current_user, description: params[:event_description], price: params[:event_price], location: params[:event_location])
    if @event.save
      redirect_to event_path(@event.id), success: 'Ton événement est en ligne !'

    else
      flash.now[:danger] = 'Retente ta chance !'
      render :new
    end
  end

  def edit 
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(start_date: params[:event_start_date], duration: params[:event_duration],
      title: params[:event_title], host: current_user, description: params[:event_description], price: params[:event_price], location: params[:event_location])
      redirect_to event_path(@event.id), success: 'Edition validé !'
    else
      flash[:danger] = 'Retente ta chance !'
      render :edit, status: :unprocessable_entity
      flash.discard
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

end
