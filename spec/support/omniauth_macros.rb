module OmniauthMacros
  def mock_facebook_auth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook', uid: '123545',
      info: { name: 'polina', image: 'image_url', email: 'admin@example.com' },
      credentials: { token: 'token_facebook' }
    )
  end

  def mock_twitter_auth_hash
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      provider: 'twitter', uid: '123321',
      info: { name: 'polina', image: 'image_url' },
      credentials: { token: 'token_twitter' }
    )
  end
end
