class UserMailer < ActionMailer::Base
  default from: "sec.rails@gmail.com"

  def activation_email(user)
    @user = user
    @url = 'jget.pl/login'
    #formatted_code = ERB::Util.url_encode(user.confirmation_code)
    @code = "http://jget.pl/#{user.id}/#{user.confirmation_code}"
    mail(to: @user.email, subject: '[BoardPoster] Please verify your account')
  end
end
