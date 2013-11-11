## watir_keyword_driver
=====
#### Introduction:
This framework can be used to create automation test without actually writing test scripts in ruby. 
All you need is an excel file where you will define your test script and a simple ruby test file which will call the driver.

=====
#### How to install:
gem install watir_keyword_driver

=====
#### How to use:
Your test case ruby file will look like this:


	require 'watir_keyword_driver' #Adding the gem
	require 'test/unit' #Adding testunit. We support testunit for test
	class RubyTest < Test::Unit::TestCase #Create testclass and extend TestUnit
	def test_method	#Create test method
		#Create RubyDriver object by passing path of excel and self 
		@driver = RubyDriver.new("/home/pratik/study/UIAutomation/WatirScript.xlsx",self)
		#Call call_criver method
		@driver.call_driver
	end
	end


And done.

Also have a look at the sample excel file

=====
