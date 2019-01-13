class ConfirmedUserGuard < Clearance::SignInGuard
  def call
    if user_confirmed?
      next_guard
    else
      failure I18n.t("flashes.confirm_your_email")
    end
  end
end

def user_confirmed?
  signed_in? && current_user.email_confirmed_at.present?
end

Clearance.configure do |config|
  config.allow_sign_up = true
  config.cookie_domain = ".example.com"
  config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  config.cookie_name = "remember_token"
  config.cookie_path = "/"
  config.routes = false
  config.httponly = false
  config.mailer_sender = "confirmation@chatapp.com"
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = "/"
  config.rotate_csrf_on_sign_in = false
  config.secure_cookie = false
  # config.sign_in_guards = [ConfirmedUserGuard]
  config.user_model = User
end