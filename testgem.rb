require 'watir_keyword_driver'
require 'test/unit' 

class RubyTest < Test::Unit::TestCase

	def test_method
		@driver = RubyDriver.new("/home/pratik/study/UIAutomation/WatirScript.xlsx",self)
		@driver.call_driver
	end
end