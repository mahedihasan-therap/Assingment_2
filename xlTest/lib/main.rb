require 'rubygems'
require 'benchmark'
require 'roo'
require_relative 'data_type.rb' 
time=Benchmark.measure do
confg=File.open('..\test_data\module_1/conf','r')
counter=0
while (line=confg.gets)
	if counter>0
		match=/=/.match(line)
		if match
			match_pre="#{match.pre_match}"
			match_post="#{match.post_match}"
			#data sourcew type
			if match_pre=~/data_source_type/
				sys=match_post.chomp
			end
			#getting souce file name
			if match_pre=~/source_file_name/
				so=match_post.chomp
			end
			#getting staeting row no.
			if match_pre=~/start_from_line_no/
				r=match_post.chomp
				row_start=r.to_i
			end
		end
	end
	counter=counter+1
end
confg.close

#creating .html file file and use html tag
html_file=File.new('..\test_report\module_1\report.html','w+')
html_file.write('<!DOCTYPE html>
<html>
<body>
<p style="color:blue">
<b>This is a table of showing data: 
</p>
<table border="1"style="width:100%"><tr> <th>Name</th>
    <th>Birthday</th><th>Contact no:</th></tr>')
	
 if sys=~/file_system/
	#using source file name
	source_file_dir='..\test_data\module_1/'+"#{so}"
	s = Roo::Spreadsheet.open("#{source_file_dir}")
	column_range=s.last_column
	#collecting data_type of different column
	a=collect_data_type(column_range)
	#checking data with specific data type
	s.first_row.upto(s.last_row) do |row|
    s.first_column.upto(s.last_column) do |column| 
    data = s.cell(row, column)
	if row>=row_start
		#msg collecting and write in report.html
		msg=error_generate(a,data,row,column,column_range) 
		html_file.write("#{msg}")
	end
	end
end
end
html_file.write("</table>

</body>
</html>")
html_file.close

end.total

print time.to_s
