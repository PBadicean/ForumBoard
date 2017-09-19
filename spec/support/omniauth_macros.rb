module OmniauthMacros
  def mock_facebook_auth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook', uid: '123545',
      info: { name: 'polina', image: 'image_url', email: 'badichan@mail.com' },
      credentials: { token: 'token_facebook' }
    )
  end
end
