class ApplicationMailer < ActionMailer::Base
  default from: 'camphood.freesite@gmail.com',
          bcc: 'camphood.freesite@gmail.com'
  layout 'mailer'
end
