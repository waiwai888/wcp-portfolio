class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    posts_followed_index_path
  end

  unless Rails.configuration.consider_all_requests_local
    rescue_from Exception,                      with: :_render_500
    rescue_from ActiveRecord::RecordNotFound,   with: :_render_404
    rescue_from ActionController::RoutingError, with: :_render_404
  end

  def render_404
    _render_404()
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :account_name])
    end

  private
    def _render_404(e = nil)
      logger.info "Rendering 404 with excaption: #{e.message}" if e

      if request.format.to_sym == :json
        render json: { error: "404 Not Found" }, status: :not_found
      else
        render "errors/404.html", status: :not_found, layout: "error"
      end
    end

    def _render_500(e = nil)
      logger.error "Rendering 500 with excaption: #{e.message}" if e

      if request.format.to_sym == :json
        render json: { error: "500 Internal Server Error" }, status: :internal_server_error
      else
        render "errors/500.html", status: :internal_server_error, layout: "error"
      end
    end
end
