require "test_helper"

class TagTest < ActiveSupport::TestCase
  setup { @subject = tags(:tag_1) }

  test('has many taggings') { assert_equal(4, @subject.taggings.size) }

  test('title required') { assert_present(:title) }
end
