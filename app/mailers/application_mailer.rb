# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@email.com'
  layout 'mailer'
end
