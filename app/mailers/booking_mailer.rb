class BookingMailer < ApplicationMailer
  default from: Rails.application.credentials.dig(:email)
  def ticket_email(booking)
    @booking = booking
    @user = booking.user
    @trip = booking.trip
    mail(to: @user.email, subject: "Ticket Confirmation")
  end
end
