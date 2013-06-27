# Where should we go to lunch today?
class Robut::Plugin::Mustache
  include Robut::Plugin

  desc "mustache [link to image] - mustache http://qph.is.quoracdn.net/main-thumb-13344067-200-dwYuwkkXzLucQmVKOwuDQQc3RzixxY29.jpeg"
  match /^mustache (.+)$/, :sent_to_me => true do |url|
    query_string = URI.encode_www_form("src" => url)
    uri = URI::HTTP.build({:host => "mustachify.me", query: query_string})
    reply "Bro, you totally look like Ron Jeremy"
    reply uri.to_s
  end

  Robut::Plugin.plugins << self

end

