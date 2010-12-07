class ApplicationController < ActionController::Base
  protect_from_forgery

private

  def authorize_admin!
    unless current_user.role?(:admin)
      redirect_to(root_path)
    end
  end
end
