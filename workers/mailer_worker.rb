require "action_mailer"
require 'bot_mailer.rb'

def init_mailer
  #Need to convert to proper hashes
  mailer_config = params['mailer'].inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo }
  # set default views dir to current dir
  ActionMailer::Base.prepend_view_path('.')
  ActionMailer::Base.smtp_settings = mailer_config
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.view_paths = File.expand_path('./')
end

# params['mailer'] = {:address=>"smtp.gmail.com", :port=>587, :domain=>"gmail.com", :authentication=>:plain, :user_name=>"ironbot.official", :password=>""}
init_mailer
BotMailer.spam(params[:to]).deliver
