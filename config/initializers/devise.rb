# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 12

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.scoped_views = true

  config.sign_out_via = :delete

  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  OmniAuth.config.allowed_request_methods = %i[get post]

  if Rails.env.production?
    config.omniauth :github, 'a312ada3100765a4369f', '261a493567e2238e9e7bd53baaa3befeb7e7ec9f', scope: 'user,public_repo'
  else
    config.omniauth :github, 'b4f00ba0ec4fe62c2664', '055d6ff9725b97521800373f4fbbdfe5a60bc016', scope: 'user,public_repo'
  end
end
