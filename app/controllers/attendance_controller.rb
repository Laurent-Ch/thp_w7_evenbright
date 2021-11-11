# frozen_string_literal: true

class AttendanceController < ApplicationController
  def new; end

  def create
    # Amount in cents
    @amount = 500

    # Added
    event = Event.find(params[:event_id])
    guest = current_user

    customer = Stripe::Customer.create({
                                         email: params[:stripeEmail],
                                         source: params[:stripeToken]
                                       })

    # Go back to Stripe::Charge ???
    charge = Stripe::Charge.create({
                                     customer: customer.id,
                                     amount: @amount,
                                     description: 'Rails Stripe customer',
                                     currency: 'usd'
                                   })

    Attendance.create(stripe_customer_id: customer.id, guest: guest, event: event)
  rescue Stripe::CardError => e
    flash[:error] = e.messages
    redirect_to new_attendance_path
  end
end
