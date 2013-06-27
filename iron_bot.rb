ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', __FILE__)

require 'rubygems'
require 'bundler'
Bundler.require

require 'robut/storage/yaml_store'

require 'robut/plugin/ping'
require 'robut/plugin/help'
Robut::Plugin.plugins << Robut::Plugin::Ping
Robut::Plugin.plugins << Robut::Plugin::Help

Dir[File.expand_path('../plugins/*.rb', __FILE__)].each do |plugin|
  puts plugin
  require plugin
end


# Add the plugin classes to the Robut plugin list.
# Plugins are handled in the order that they appear in this array.
# Configure the robut jabber connection and you're good to go!
Robut::Connection.configure do |config|
  # Note that the jid must end with /bot if you don't want robut to
  # spam the channel, as described by the last bullet point on this
  # page: https://www.hipchat.com/help/category/xmpp

  # Custom @mention name
  config.jid          = ENV['IRON_BOT_JID']
  config.password     = ENV['IRON_BOT_PASSWORD']
  config.room         = ENV['IRON_BOT_RO']
  config.nick         = 'iron bot'
  config.mention_name = 'bot'

  # Some plugins require storage
  Robut::Storage::YamlStore.file = ".robut"
  config.store = Robut::Storage::YamlStore

  # Add a logger if you want to debug the connection
  # config.logger = Logger.new(STDOUT)
end

