#!/usr/bin/env ruby

#--
# Portions copyright 2004 by Jim Weirich (jim@weirichhouse.org).
# Portions copyright 2005 by Sam Ruby (rubys@intertwingly.net).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#++

#!/usr/bin/env ruby

require 'test/unit'
require 'builder/xchar'

class TestXmlEscaping < Test::Unit::TestCase
  def test_ascii
    assert_equal 'abc', 'abc'.to_xs
  end

  def test_invalid
    assert_equal '*', "\x00".to_xs               # null
    assert_equal '*', "\x0C".to_xs               # form feed
    assert_equal '*', "\xEF\xBF\xBF".to_xs       # U+FFFF
  end

  def test_iso_8859_1
    assert_equal '&#231;', "\xE7".to_xs          # small c cedilla
    assert_equal '&#169;', "\xA9".to_xs          # copyright symbol
  end

  def test_win_1252
    assert_equal '&#8217;', "\x92".to_xs         # smart quote
    assert_equal '&#8364;', "\x80".to_xs         # euro
  end

  def test_utf8
    assert_equal '&#8217;', "\xE2\x80\x99".to_xs # right single quote
    assert_equal '&#169;',  "\xC2\xA9".to_xs     # copy
  end
 
  def test_utf8_verbatim
    assert_equal "\xE2\x80\x99", "\xE2\x80\x99".to_xs(false)  # right single quote
    assert_equal "\xC2\xA9",  "\xC2\xA9".to_xs(false)         # copy
    assert_equal "\xC2\xA9&\xC2\xA9",
      "\xC2\xA9&\xC2\xA9".to_xs(false)                        # copy with ampersand
  end
end
