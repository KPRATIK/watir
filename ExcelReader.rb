require 'roo'

class ExcelReader
@workbook

def initialize(file_path)
	puts "Opening Excel at #{file_path}"
    @workbook = Roo::Excelx.new(file_path)
    @workbook.default_sheet = @workbook.sheets[0]
 end

def get_workbook
	return @workbook
end

def find_header
  	@headers = Hash.new
  	puts "finding excel header"
	@workbook.row(1).each_with_index {|header,i|
	@headers[header] = i
	}
	return @headers
end

def print_data
	headers = find_header
	((@workbook.first_row + 1)..@workbook.last_row).each do |row|
	# Get the column data using the column heading.
	run = @workbook.row(row)[headers['run']]
	keyword = @workbook.row(row)[headers['keyword']]
	object = @workbook.row(row)[headers['object']]
	property = @workbook.row(row)[headers['property']]
	value = @workbook.row(row)[headers['value']]
	comments = @workbook.row(row)[headers['comments']]
	 
	print "Run: #{run}, #{keyword}, #{object}, #{property}, #{value}, #{comments}}\n\n"
	end
end


end
#  excel = ExcelReader.new("/home/pratik/study/UIAutomation/WatirScript.xlsx")
#  headers = excel.find_header
# headers.each do |key, value|
#   puts "#{key}-----"
#   puts "#{value}"
# end
# excel.print_data