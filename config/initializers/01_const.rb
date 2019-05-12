module Rank
  JWT_EXP =
    if Rails.env.development?
      1.year
    else
      1.day
    end

  PER_PAGE = 15
  AUTH_UN_REQUIRED = %w[/v1/users/sign_in]
  RESOURCES_MAP = {}
end
