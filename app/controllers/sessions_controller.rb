class SessionsController < Clearance::SessionsController
  def url_after_create
    home_url
  end
end
