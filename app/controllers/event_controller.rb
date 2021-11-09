# frozen_string_literal: true

class EventController < ApplicationController
  def index; end

  def show
    @event = Event.find(params[:id])
    @guests = @event.guests
    @start_date = @event.start_date.strftime('%d/%m/%Y %Hh%M')
    @end_date = @event.end_date.strftime('%d/%m/%Y %Hh%M')
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
end
