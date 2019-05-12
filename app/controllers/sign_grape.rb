# base for open grapes
class SignGrape < BaseGrape
  # use Middleware::TokenRefresh
  helpers AuthHelper

  before do
    if authenticate_required?
      verify_jwt!
    end
  end

  rescue_from(SignError) { |e| valid_error!(e) }
  rescue_from(Svc::JwtSignature::SignError) { |e| auth_error!(e) }
  rescue_from(PermissionDeniedError) { |e| permit_error!(e) }

  # mounts
  mount V1::UsersGrape => '/v1/users'
end
