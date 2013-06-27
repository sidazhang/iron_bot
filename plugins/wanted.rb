# Where should we go to lunch today?
require 'HTTParty'

class Robut::Plugin::Wanted
  include Robut::Plugin

  # Returns a description of how to use this plugin
  def usage
    [
      "spam [email address] - spam sidazhang89@gmail.com"
    ]
  end

  # Replies with a random string selected from +places+.
  def handle(time, sender_nick, message)
    words = words(message)
    if words[1] == "wanted"
      # HTTParty.post("http://localhost:3000/mailer", {:body => {:to => words[2]}})
      reply "Target acquired! I am going to find that sucker. #{words[2]} is doomed"
    end
  end

  Robut::Plugin.plugins << self

end
