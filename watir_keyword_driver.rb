require_relative 'ExcelReader'
require_relative 'RubyUtility'
require_relative 'RubyReport'
require "watir-webdriver"

class RubyDriver

def initialize(file_path,testcase)
	@excel = ExcelReader.new("#{file_path}")
	@rubyutil = RubyUtility.new
	@workbook = @excel.get_workbook
	@headers = @excel.find_header
	@rubyreport = RubyReport.new
	@testcase = testcase
 end

def call_driver
	((@workbook.first_row + 1)..@workbook.last_row).each do |row|
	# Get the column data using the column heading.
	run = @workbook.row(row)[@headers['run']]
	keyword = @workbook.row(row)[@headers['keyword']]
	object = @workbook.row(row)[@headers['object']]
	property = @workbook.row(row)[@headers['property']]
	value = @workbook.row(row)[@headers['value']]
	comments = @workbook.row(row)[@headers['comments']]
	
	if "#{@rubyutil.get_string_upcase("#{run}")}" == "R"
		run_test_case("#{keyword}","#{object}","#{property}","#{value}","#{comments}")
	else
		puts "Skipping : #{keyword}, #{object}, #{property}, #{value}, #{comments}}\n\n"
	end

	end
end

def run_test_case(keyword,object,property,value,comments)
	puts "Running: #{keyword}, #{object}, #{property}, #{value}, #{comments}}\n\n"
	take_action("#{keyword}","#{object}","#{property}","#{value}","#{comments}")
end

def create_object(object,property,value)
	obj_property = @rubyutil.get_property("#{property}")
	if obj_property
		propkey = obj_property.first.strip
		prop_value = obj_property.last.strip
		prop_key = :"#{propkey}"
		obj_identifier = Hash.new
		obj_identifier[prop_key] = "#{prop_value}"
	end
	case "#{@rubyutil.get_string_upcase("#{object}")}"
	when "BROWSER"
		case "#{@rubyutil.get_string_upcase("#{property}")}"
		when "FIREFOX"
			@browser = Watir::Browser.new :ff
		when "CHROME"
			@browser = Watir::Browser.new :chrome	
		end
		return @browser
		
	when "LINK"
		return @browser.a(obj_identifier)

	when "TEXT_BOX"
		return @browser.text_field(obj_identifier)

	when "BUTTON"
		return @browser.button(obj_identifier)

	when "DIV"
		return @browser.div(obj_identifier)

	when "RADIO"
		return @browser.radio(obj_identifier)

	when "CHECKBOX"
		return @browser.checkbox(obj_identifier)
	when "IMAGE"
		return @browser.image(obj_identifier)
	else
		return "#{object}"
	end
end

#def take_action(object,keyword,value)
def take_action(keyword,object,property,value,comments)
	obj  = create_object("#{object}","#{property}","#{value}")
	value_property = @rubyutil.get_value("#{value}")
	if value_property
		value_prop = value_property.first.strip
		value_value = value_property.last.strip
	end
	value_prop = @rubyutil.get_hash_value("#{value_prop}")
	value_value = @rubyutil.get_hash_value("#{value_value}")

	case "#{@rubyutil.get_string_upcase("#{keyword}")}"
	when "LAUNCH"
		puts "launching #{value}"
		obj.goto value_prop
	when "CLICK"
		puts "clicking"
		obj.when_present.flash
		obj.click
	when "SET"
		puts "setting"
		puts object
		obj.when_present.flash
		obj.set value_prop
	when "CHECK"
		puts "checking"
		obj.when_present.flash
		obj.set
	when "CLEAR"
		puts "clearing"
		obj.when_present.flash
		obj.clear
	when "ASSIGN"
		puts "assigning"
		puts obj
		@var = obj
		puts "#@var"
		if "#{property}" == "time"
			var_value = Time.now.to_i
			hash_var = @rubyutil.create_hash(obj,var_value)
		else
			hash_var = @rubyutil.create_hash(obj,"#{property}")
		end
	when "PUTS"
		puts "putting"
		puts "#{object}"
		puts @rubyutil.get_hash_value("#{object}")
	when "CONCAT"
		puts "concating"
		puts "#{property}"
		str_concat = @rubyutil.get_str_concat("#{property}")
		hash_var = @rubyutil.create_hash(obj,"#{str_concat}")
	when "STOREVALUE"
		puts "storing"
		puts value_prop
		puts value_value
		obj.wait_until_present
		obj.flash	
		if value_prop == "text"
			@rubyutil.create_hash(value_value,obj.text)
		elsif value_prop == "exist"
			@rubyutil.create_hash(value_value,obj.exists?)
		elsif value_prop == "title"
			@rubyutil.create_hash(value_value,@browser.title)
		end	
	when "VERIFY"
		puts "verifying"
		puts value_prop
		puts value_value
		obj.wait_until_present
		obj.flash	
		if value_prop == "text"
			@testcase.assert_equal(obj.text, value_value,"Text does not match")
			# puts object.text.should == value_value
		elsif value_prop == "exist"
			value_boolean = value_value == "true" ? true : false
			@testcase.assert_equal(obj.exists?,value_boolean,"Object does not exist")
			# puts object.exists?.should == value_value
		elsif value_prop == "title"
			@testcase.assert_equal(@browser.title,value_value,"Title does not match")
		end
	when "CLOSE"
			obj.close
			@rubyreport.total_no_of_assertion
	end
end

def create_report
	# @browser.close
	puts "Total Assertion = #{@rubyreport.total_no_of_assertion}\n\n"
	puts "Total Pass = #{@rubyreport.total_no_of_pass}\n\n"
	puts "Total Fail = #{@rubyreport.total_no_of_fail}\n\n"
	
end

end