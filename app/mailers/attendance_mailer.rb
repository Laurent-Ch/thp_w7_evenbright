# frozen_string_literal: true

class AttendanceMailer < ApplicationMailer
  default from: 'violette.marquis@gmail.com'

  def warning_email(attendance)
    # on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @attendance = attendance
    @event = attendance.event
    @host = @event.host

    # on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://eventbright-paris-thp.herokuapp.com/'

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @host.email, subject: 'Un nouveau participant à votre événement !')
  end
end
