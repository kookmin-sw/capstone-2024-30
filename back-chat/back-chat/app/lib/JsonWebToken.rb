# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = ENV["JWT_SECRET"]

  def self.decode(token)
    decoded = JWT.decode(token, Base64.decode64(SECRET_KEY), true, { algorithm: 'HS256' })
    HashWithIndifferentAccess.new(decoded.first)
  end
end
