# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = 'ment-menu-2021'

  def self.encode(payload, exp = 10.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
