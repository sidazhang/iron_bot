# Where should we go to lunch today?
class Robut::Plugin::Mustache
  include Robut::Plugin

  # Returns a description of how to use this plugin
  def usage
    [
      "mustache [link to image] - mustache http://qph.is.quoracdn.net/main-thumb-13344067-200-dwYuwkkXzLucQmVKOwuDQQc3RzixxY29.jpeg"
    ]
  end

  # Replies with a random string selected from +places+.
  def handle(time, sender_nick, message)
    words = words(message)
    query_string = URI.encode_www_form("src" => words[2])
    uri = URI::HTTP.build({:host => "mustachify.me", query: query_string})
    if words[1] == "mustache"
      reply "Bro, you totally look like Ron Jeremy"
      reply uri.to_s
    end
  end

end
