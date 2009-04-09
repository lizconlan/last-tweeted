ActionController::Routing::Routes.draw do |map|
  map.connect ':screen_name.:format', :controller => 'twitterer', :action => 'show'
  map.connect ':screen_name', :controller => 'twitterer', :action => 'show'
end
