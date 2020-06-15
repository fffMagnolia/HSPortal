class ApplicationController < ActionController::Base
  include SessionsHelper

  # rescure_fromはスタックされることに注意
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404(e = nil)
    if e
      logger.info("Rendering 404 with exception: #{e.message}")
    end
    # 静的ファイルならprodではデフォルトでpublic/配下のが動く
    render template: "errors/error_404", status: 404, layout: 'application'
  end

  private

    def logged_in_user
      if !logged_in?
        store_location
        flash[:danger] = 'この操作を行うにはログインが必要です。'
        redirect_to login_url
      end
    end
end
