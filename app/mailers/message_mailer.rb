class MessageMailer < ApplicationMailer
  def new_message_email
    @message = params[:message]

    mail(to: "nvphongbk@gmail.com", subject: "You got a new messages!")
    # mail(to: [@message.email,"nvphongbk@gmail.com"], subject: "You got a new messages!")
  end
end
