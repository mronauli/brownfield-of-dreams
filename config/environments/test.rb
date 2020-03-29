Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Store uploaded files on the local file system in a temporary directory
  config.active_storage.service = :test

  config.action_mailer.perform_caching = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  module OmniauthMacros
    def mock_auth_hash
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        {'provider'=>"github",
         'uid'=>"55954962",
         'info'=>
          {'nickname'=>"mronauli",
           'email'=>nil,
           'name'=>"Maria",
           'image'=>"https://avatars3.githubusercontent.com/u/55954962?v=4",
           'urls'=>{"GitHub"=>"https://github.com/mronauli", "Blog"=>""}},
         'credentials'=>{"token"=>ENV["GITHUB_ACCESS_TOKEN_1"], "expires"=>false},
         'extra'=>
          {'raw_info'=>
            {'login'=>"mronauli",
               'id'=>55954962,
               'node_i'=>"MDQ6VXNlcjU1OTU0OTYy",
               'avatar_url'=>"https://avatars3.githubusercontent.com/u/55954962?v=4",
               'gravatar_id'=>"",
               'url'=>"https://api.github.com/users/mronauli",
               'html_url'=>"https://github.com/mronauli",
      }}})
    end
  end
end
