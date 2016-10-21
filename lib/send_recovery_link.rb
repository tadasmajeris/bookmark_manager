require 'mailgun'

class SendRecoveryLink

 def initialize(mailer: nil)
   Mailgun.configure do |config|
  config.api_key = ""
  config.domain  = ""
    end
   @mailer = mailer || Mailgun::Client.new(ENV['api_key'])
  end

 def self.call(user, mailer = nil)
   new(mailer: mailer).call(user)
 end

 def call(user)
   mailer.send_message(ENV['domain_name'],
     {from: 'bookmarkmanager@mail.com',
      to: user.email,
      subject: "Reset your password",
      text: "click here to reset your password http://yourherokuapp.com/reset_password?token=#{user.password_token}"})
  end

  private
  attr_reader :mailer
end
