## watir_keyword_driver
=====
## Introduction:
This framework can be used to create automation test without actually writing test scripts in ruby. 
All you need is an excel file where you will define your test script and a simple ruby test file which will call the driver.
=====
### How to install:
gem install watir_keyword_driver
=====
### How to use:
Your test case ruby file will look like this:

add the gem
	require 'watir_keyword_driver' 
We use testunit for all assertion and test
	require 'test/unit' 
Simple enough. Create a class which extends test unit
	class RubyTest < Test::Unit::TestCase
Method to run
	def test_method	
Create RubyDriver object by passing path of excel(Actual test-case) and self
		@driver = 		RubyDriver.new("/home/pratik/study/UIAutomation/WatirScript.xlsx",self)
		
call the method call_driver
		@driver.call_driver
		end
	end


 And done

