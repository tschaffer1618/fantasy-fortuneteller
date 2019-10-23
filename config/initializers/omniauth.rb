Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    :name => "google",
    # add in more?
    :scope => ['contacts','plus.login','plus.me','email','profile'],
    # this line was added to get rid of OmniAuth::Strategies::OAuth2::CallbackError
    # csrf_detected, may need different appraoch
    # provider_ignores_state: true,
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50,
    :access_type => 'offline'
  }
end
