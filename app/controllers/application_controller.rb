# hoeeeeee
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_env
    case Rails.env
      when 'production'
        return "pro"
      when 'development'
        return "dev"
      when 'test'
        return "test"
    end
  end
end
