require 'jwt'

class Auth

  def self.issue(payload)
    JWT.encode(
      payload,
      Rails.application.secrets.secret_key,
      'HS256'
    )
  end

  def self.decode(token)
    JWT.decode(
      token,
      Rails.application.secrets.secret_key,
      true,
      { algorithm: 'HS256' }
    ).first
  end
end
