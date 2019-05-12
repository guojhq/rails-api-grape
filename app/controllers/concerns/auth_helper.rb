# helpers for sign grape
module AuthHelper
  def verify_jwt!
    payload = Svc::JwtSignature.verify!(request.headers['Authorization']).first
    @current_user = User.build_with(payload)

    raise SignError, '校验失败, 请退出重新登录' if @current_user.nil?

    @payload = @current_user.payload
  end

  def authenticate_required?
    !AUTH_UN_REQUIRED.include?(request.path)
  end

  def current_user
    @current_user ||= User.build_with(@payload)
  end

  def resource_name
    request.request_method + routes.first.origin
  end

  def verify_resources!
    current_user.has_resources!(resource_name)
  end
end
