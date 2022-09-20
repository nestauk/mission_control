require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1280, 800]

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "123456789",
      info: {
        first_name: "First",
        last_name: "Last",
        email: "email@example.com"
      }
    }
  )

  def sign_in
    visit root_path
    click_button 'Sign in with Google'
    assert_text 'Successfully authenticated from Google account'
  end

  def assert_requires_sign_in(path)
    visit path
    assert_current_path root_path
    assert_text 'Please sign in'
  end
end
