class ApplicationController < ActionController::Base
  before_action :check_logged_in, :load_shortcuts

  private

  def load_shortcuts
    @shortcuts ||= Shortcut.all.group_by(&:category)
  end

  def check_logged_in
    return if %w[pages omniauth_callbacks].include?(controller_name) || user_signed_in?
    redirect_to(root_path, notice: 'Please sign in')
  end
end
