class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_error

  def after_sign_in_path_for(resource)
    posts_path
  end



  private

  def redirect_to_error
    redirect_to no_page_path # エラーページへ遷移する
  end



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
