require 'jwt'

module JwtToken
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secrets.access_token_key.to_s || 'this is a demo key'

  def self.sign(payload, exp = 1.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.verify(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
