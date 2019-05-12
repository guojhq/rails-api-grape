class UserMailer < ApplicationMailer

  def reset_email(user)
    mail(to: user.email, subject: 'Reset your password') do |format|
      format.text { render plain: "Hi, #{user.email}, Your reset password code is #{user.gen_code}" }
    end
  end
end
