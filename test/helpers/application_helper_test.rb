require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "formats page specific title" do
    content_for(:title) { "Home" }
    assert_equal "Home | #{I18n.t('piazza')}", title
  end

  test "returns default title" do
    assert_equal I18n.t('piazza'), title
  end
end
