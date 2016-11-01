require 'mailgun'

class SendRecoveryLink

 def initialize(mailer: nil)
  # Mailgun.configure do |config|
  #   config.api_key = "key-a558e70d1b43b5c1aa223c2c69511e41"
  #   config.domain  = ""
  # end
  @mailer = mailer || Mailgun::Client.new('key-a558e70d1b43b5c1aa223c2c69511e41')
  end

 def self.call(user, mailer = nil)
   new(mailer: mailer).call(user)
 end

 def call(user)
   mailer.send_message("api.mailgun.net/v3/sandbox0c6d2c52bf0c45c3beb2f41cbc517c7d.mailgun.org",
     {from: 'bookmarkmanager@mail.com',
      to: user.email,
      subject: "Reset your password",
      text: "click here to reset your password http://yourherokuapp.com/reset_password?token=#{user.password_token}"})
  end

  private
  attr_reader :mailer
end
