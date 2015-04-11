if Rails.env.test?
  OmniAuth.config.test_mode = true
  providers = [:github]
  providers.each do |provider|
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
      info: {
        email: 'hello@instaemploy.com',
        provder: provider.to_s,
        uid: '12345',
        urls: {
          "GitHub" => "http://instaemploy.com"
        }
      },
      extra: {
        raw_info: {
          hireable: false
        }
      }
    })
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_SECRET'], scope: 'user, private_repo, public_repo'
  provider :bitbucket, ENV['BITBUCKET_KEY'], ENV['BITBUCKET_SECRET']
end