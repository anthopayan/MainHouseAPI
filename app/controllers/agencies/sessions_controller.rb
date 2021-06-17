class Agencies::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
  render json: { message: 'You are logged in.', agency: headers, token: resource, current_agency: current_agency }, status: :ok, "agency": :current_agency
  end

  def respond_to_on_destroy
    log_out_success && return if current_agency

    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Hmm nothing happened."}, status: :unauthorized
  end
end