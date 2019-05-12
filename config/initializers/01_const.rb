module RANK
  JWT_EXP =
    if Rails.env.development?
      1.year
    else
      1.day
    end

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  PER_PAGE = 15
  AUTH_UN_REQUIRED = %w[/v1/users/sign_in /v1/users/sign_up /v1/users/send_mail /v1/users/reset]
  RESOURCES_MAP = {}
end
