require 'test/unit'

class RubyReport < Test::Unit::TestCase

@@no_of_assertion =0
@@no_of_pass = 0
@@no_of_fail = 0


	def initialize
		
	end

	def assert_equal(actual,expected,msg)
		@@no_of_assertion += 1
		begin
      		puts super(expected, actual, msg)
      		puts "PASS ----- #{msg}"
      		@@no_of_pass += 1
    	rescue MiniTest::Assertion
    		@@no_of_fail += 1
      		puts "FAIL ----- #{msg}" # make screenshot here
 		end
      	
    end

	def total_no_of_assertion
       return @@no_of_assertion
    end

    def total_no_of_pass
       return @@no_of_pass
    end

    def total_no_of_fail
       return @@no_of_fail
    end

end
