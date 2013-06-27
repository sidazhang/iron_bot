# Where should we go to lunch today?
require 'action_mailer'

class Robut::Plugin::IronSpam
  include Robut::Plugin

  desc "ironspam [email] - ironspam sidazhang89@gmail.com"
  match /^ironspam (.+)$/, :sent_to_me => true do |email|
    begin
      mailer_settings = ActionMailer::Base.smtp_settings = {
         :address              => ENV["IRON_MAILER_ADDRESS"],
         :port                 => ENV['IRON_MAILER_PORT'],
         :domain               => ENV['IRON_MAILER_DOMAIN'],
         :authentication       => ENV['IRON_MAILER_AUTHENTICATION'],
         :user_name            => ENV['IRON_MAILER_USER_NAME'],
         :password             => ENV['IRON_MAILER_PASSWORD'],
         :enable_starttls_auto => true
        }

      iw_client = IronWorkerNG::Client.new(:token => ENV["IRON_TOKEN"], :project_id => ENV['IRON_PROJECT_ID'])
      ic_client = IronCache::Client.new(:token => ENV["IRON_TOKEN"], :project_id => ENV['IRON_PROJECT_ID'])

      schedule = iw_client.schedules.create('MailerWorker',
                                {:mailer => mailer_settings, :to => email},
                                {:run_every => 60, :start_at => Time.now})
      @cache = ic_client.cache("spam_schedules")
      @cache.put(email, schedule.id)
    rescue => e
      reply e.inspect
    end
    reply "Target acquired! I am going to find that sucker."
  end

  desc "ironcancel [email] - ironcancel sidazhang89@gmail.com"
  match /^ironcancel (.+)$/, :sent_to_me => true do |email|
    begin
      iw_client = IronWorkerNG::Client.new(:token => ENV["IRON_TOKEN"], :project_id => ENV['IRON_PROJECT_ID'])
      ic_client = IronCache::Client.new(:token => ENV["IRON_TOKEN"], :project_id => ENV['IRON_PROJECT_ID'])

      @cache = ic_client.cache("spam_schedules")
      iw_client.schedules.cancel(@cache.get(email).value)
      @cache.delete(email)
    rescue => e
    reply e.inspect
    end
    reply "Cool. I am going to let the sucker go!"
  end

  Robut::Plugin.plugins << self

end
