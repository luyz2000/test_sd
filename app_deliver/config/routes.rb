Rails.application.routes.draw do
  root "visitor#index"
  post "/async_track_codes" => "visitor#procces_json"
end
