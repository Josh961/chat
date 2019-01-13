class PasswordsController < Clearance::PasswordsController
  def url_after_update
    redirect_to sign_in_url
  end
end
