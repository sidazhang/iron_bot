require 'action_mailer'
class BotMailer < ActionMailer::Base
  default from: "ironbot.official@gmail.com"
  def spam(email)
    mail(:to => email, :subject => "Dude, stop slacking off!") do |format|
      format.html
    end
  end
end
