ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def assert_error(key, msg, subject: @subject)
    assert_includes(subject.errors[key], msg)
  end

  def assert_present(key, msg: "can't be blank", subject: @subject, value: nil)
    subject.send("#{key}=", value)
    subject.valid?
    assert_error(key, msg)
  end

  def assert_downcase(key, subject: @subject, value: 'UPPERCASE')
    subject.send("#{key}=", value)
    @subject.valid?
    assert_equal('uppercase', @subject.send(key))
  end

  def assert_strip_whitespace(key, subject: @subject, value: ' Whitespace ')
    subject.send("#{key}=", value)
    @subject.valid?
    assert_equal('Whitespace', @subject.send(key))
  end
end
