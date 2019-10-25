class UserVerificationMailer < ApplicationMailer
  def verify(user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: 'Verify your Account')
  end
end
