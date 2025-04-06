module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :authenticate, options
    end
  end

  def encode(payload)
    now = Time.now.to_i
    JWT.encode(
      {
        data: {
          id: payload.id,
          email_address: payload.email_address
        },
        exp: now + 3.minutes.to_i,
        iat: now,
        iss: "supplements_api",
        aud: "supplements_client",
        sub: "User",
        jti: SecureRandom.uuid,
        nbf: now + 1.second.to_i,
      },
      Rails.application.credentials.jwt_secret,
      "HS256",
      {
        typ: "JWT",
        alg: "HS256"
      })
  end

  def decode
    token = get_token
    JWT.decode(token, Rails.application.credentials.jwt_secret, 'HS256')
  end

private
  def get_token
    request.headers["Authorization"].split(" ").last
  end

  def current_user
    decoded = decode
    decoded.first["data"].with_indifferent_access
  end

  def authenticate
    begin
      if current_user
        current_user
      else
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    rescue JWT::ExpiredSignature
      render json: { error: "Token has expired" }, status: :unauthorized
    end
  end
end
