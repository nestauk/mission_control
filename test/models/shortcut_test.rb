require "test_helper"

class ShortcutTest < ActiveSupport::TestCase
  setup { @subject = shortcuts(:shortcut_project) }

  test('title required') { assert_present(:title) }

  test('path required') { assert_present(:path) }

  test('category in') { assert_present(:category, msg: 'is not included in the list') }
end
