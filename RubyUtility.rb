class RubyUtility

def initialize
	@var_hash = Hash.new
end
def get_string_upcase(str)
	return String.new("#{str}").upcase.strip
end

def get_string_trim(str)
	return String.new("#{str}").strip
end

def get_property(str)
	if "#{str}"!=""
		prop = String.new("#{str}")
		return prop.split('=',2)
	end
end

def get_str_concat(str)
	if "#{str}"!=""
		new_str = String.new("")
		str_list = str.split(",")
		for index in 0 ... str_list.size	
  			str_temp = "#{str_list[index].inspect}"
  			# if(str_temp[1,1]=="@")
  			# 	str_add = get_hash_value(str_temp[2..-2])
  			# else
  			# 	str_add = str_temp[1..-2]
  			# end
  			str_add = get_hash_value(str_temp[1..-2])
  			new_str = new_str+str_add
  			puts new_str
		end

	end
	return new_str
end

def get_value(str)
	if "#{str}"!=""
		prop = String.new("#{str}")
		return prop.split('<>',2)
	end
end

def create_hash(key,value)
	prop_key = :"#{key}"
	@var_hash[prop_key] = "#{value}"
	return @var_hash
end

def get_hash_value(key)
	prop_key = :"#{key}"
	if @var_hash.key?(prop_key)
		return @var_hash[prop_key]
	else
		return "#{key}"
	end
	
end

end