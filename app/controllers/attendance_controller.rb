class AttendanceController < ApplicationController
  
  before_action :authenticate_user!, only: [:new]
  before_action :is_host?, only: [:new]
  before_action :is_already_a_guest?, only: [:new]
  before_action :is_admin?, only: [:index]

  def index
    @attendances = Attendance.where(event_id: params[:event_id])
    @event = Event.find(params[:event_id])
  end

  def new
    @user = current_user
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new
  end

  def create
    @user = current_user
    @event = Event.find(params[:event_id])
    @amount = (@event.price)

      customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
      })

      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: "Achat d'un produit",
      currency: 'eur',
      })
      
      @attendance = Attendance.create(guest: @user, event: @event, stripe_customer_id: customer.id)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      render 'new'
  end

  private

#ne marchera que si la personne n'est pas admin (if)
  def is_host?
    @event = Event.find(params[:event_id])
    if current_user == @event.host
      flash[:danger] = "Tu ne peux participer, tu organises !"
      redirect_to event_path(params[:event_id])
    end
  end

  #ne marchera que si la personne ne participe pas (if)
  def is_already_a_guest?
    @event = Event.find(params[:event_id])
    if @event.guests.include? current_user
      flash[:danger] = "Tu participes déjà (idiot)"
      redirect_to event_path(params[:event_id])
    end
  end

  #ne marchera que si la personne est l'host (unless)
  def is_admin?
    @event = Event.find(params[:event_id])
    unless current_user == @event.host
      flash[:danger] = "Tu n'as pas l'autorisation"
      redirect_to event_path(params[:event_id])
    end
  end

end
