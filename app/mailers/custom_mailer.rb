class CustomMailer < ActionMailer::Base

  default :from => 'mailerDaemon@dead-body-flashers.com'  #SET the default EMail :from - Header


  def welcome_email(user)

    @user = user
    @url = 'http://dead-body-flashers.com/login'

    attachments['cR.png'] = File.read("#{Rails.root}/app/assets/images/cR.png")

    mail(:to => @user.email, :subject => 'Here you can meet the real heroes ;-)')#,

  end


end
