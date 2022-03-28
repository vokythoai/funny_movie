class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  PER_PAGE_PAGING = 50
end
