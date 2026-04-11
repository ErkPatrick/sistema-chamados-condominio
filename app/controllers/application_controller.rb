class ApplicationController < ActionController::Base
  include Pundit::Authorization  # habilita o pundit em todos os controllers

  before_action :authenticate_user!  # exige login em todas as páginas (devise)

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized  # captura quando o Pundit bloqueia uma ação e redireciona com uma mensagem

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def user_not_authorized
    flash[:alert] = "Você não tem permissão para realizar essa ação."
    redirect_back(fallback_location: root_path)
  end
end
