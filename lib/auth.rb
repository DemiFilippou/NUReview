require 'jwt'

class Auth

  def self.issue(payload)
    JWT.encode(
      payload,
      ENV["NUREVIEW_SECRET"],
      'HS256'
    )
  end

  def self.decode(token)
    JWT.decode(
      token,
      ENV["NUREVIEW_SECRET"],
      true,
      { algorithm: 'HS256' }
    ).first
  end
end
