##
#  to run use
#     ruby -I ./lib -I ./test test/test_relays.rb


require 'helper'



class TestRelays < MiniTest::Test


def test_relays

    assert_equal '85b10531435304cbe47d268106b58b57a4416c76573d4b50fa544432597ad670i0', Sats[ 'bitcoin.paper']
    assert_equal '8277fca13d0d5ccf70b5930e351494768ae6ed6759b318b403df229318984af3i0', Sats[ 'cypherpunk.paper']
    assert_equal '315198afb24aed9bc0b68f222eb6f2e976b7ab62bac456b30f26cbb8b893ae55i0', Sats[ 'snake.game' ]
    assert_equal '6cc328043c8e8837a421e2b869026363010fb10a5e50f89005187cadc429a821i0', Sats[ 'breakout.game' ]
    assert_equal '2d7dcad13f149e82c5f2c77b003d55b3837df3710e30ed14aa3566625de28a53i0', Sats[ '2048.game' ]
    
    assert_nil Sats[ '404 NOT FOUND' ]
end


def test_find_record
  rec = Sats::Record.find( '85b10531435304cbe47d268106b58b57a4416c76573d4b50fa544432597ad670i0' )

   assert_equal "85b10531435304cbe47d268106b58b57a4416c76573d4b50fa544432597ad670i0", rec.id
   assert_equal "bitcoin.paper", rec.name
end

end # class TestRelays

