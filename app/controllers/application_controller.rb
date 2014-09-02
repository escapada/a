class ApplicationController < ActionController::Base
  config.relative_url_root = '' #фиксит косяк связки RoR 3.0.19(до 20 вроде версии так) и ruby 2.0
  protect_from_forgery
end
