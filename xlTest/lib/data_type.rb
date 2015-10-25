def collect_data_type(range)
	column_range=range
	data_file=File.new('..\test_data\module_1\expected_data','r')
	while line=data_file.gets
		if line=~/=/
			match=/=/.match(line)
			s="#{match.post_match}"
			a=s.split(',')
			n=a.length
		end
	end
	column_data=Array.new(column_range,Array.new(n,0))
	i=0
	data_file.close
	remote_data = open('..\test_data\module_1\expected_data').read
	line=remote_data.split
	n1=line.length
	k=0
	b=Array.new
	while k<n1
		s=line[k]
		if s=~/=/
			a=s.split('=')
			b[i]=a[1]
			i=i+1
		end
		k=k+1
	end
	k=0
	while k<i
		p=b[k]
		c=p.split(",")
		column_data[k]=c
		k=k+1
	end
	return column_data
end

 def error_generate(a,d,r,c,range)
	 row=r
	 data=d
	 column=c
	 column_range=range
	 column_data=a
	 flag=0
	 flag_date=0
	 i=0
	while i<=column_range
		if i==column
			d=i-1
			data_type=column_data[d][0]
			requirement=column_data[d][1]
			regexp=column_data[d][2]
		end
		i=i+1
	end
	if requirement=='true'
		if data.nil?
			msg='<td style="color:red">row:'+"#{row},"+'column:'+"#{column}"+"require,you must fill up it"+'</td>'
			flag=1
		end
		if data_type=='string' && flag==0
			match=data.match(/^#{regexp}+$/)
			if match
				msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
			else
				msg='<td style="color:red">row:'+"#{row},"+'column:'+"#{column}   "+"require,but wrong pattern.expected regex #{regexp}"+'</td>'
			end
		end
		if data_type=='number' && flag==0
			match=data.match(/^#{regexp}+$/)
			if match
				msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
			else
				msg='<td style="color:red">row:'+"#{row},"+'column:'+"#{column}   "+"require,but wrong patter.expected regex #{regexp}"+'</td>'
			end
		end
		if data_type=='date' && flag==0
			if /dd-mm-yyyy/=~regexp 
				date_type=1
			end
			if /mm-dd-yyyy/=~regexp 
				date_type=2
			end
			if /\d\d-\d\d-\d\d\d\d/=~data
				flag_date=1
				a=data.split("-")
				if date_type==1
				dt=a[0].to_i
				mn=a[1].to_i
				end
				if date_type==2
				dt=a[1].to_i
				mn=a[0].to_i
				end
				yr=a[2].to_i
				if mn==1||mn==3||mn==5||mn==7||mn==8||mn==10||mn==12
					if dt<=31 && dt!=0
						msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
					else
						msg='<td style="color:red">row:'+"#{row},"+'column:'+"#{column}   "+'require,wrong date</td>'
					end
				end
				if mn==4||mn==6||mn==9||mn==11
					if dt<=30 && dt!=0
						msg='<td>row:'+"#{row},"+'column:'+"#{column}"+'accepted</td>'
					else
						msg='<td style="color:red">row:'+"#{row},"+'column:'+"#{column}   "+'require,wrong date</td>'
					end
				end
				if mn==2
					if dt<=29 && dt!=0 && (yr%4)==0
						msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
					elsif dt<=28 && dt!=0 && (yr%4)!=0
						msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
					else 
						msg='<td style="color:red">row:'+"#{row},"+'column:'+"#{column}   "+'require,wrong date</td>'
					end
				end
				if mn>12
					msg='<td style="color:red">row:'+"#{row},"+'column:'+"#{column}   "+'require,wrong month</td>'
				end
			end
			if flag_date==0
			 msg='<td style="color:red">row:'+"#{row},"+'column:'+"#{column}   "+"require,wrong pattern.<br>expected regex #{regexp}"+'</td>'
			end
		end
	end
	if requirement=='false'
		if data.nil?
			msg='<td style="color:blue">row:'+"#{row},"+'column:'+"#{column}   "+"not require,you could fil it."+'</td>'
			flag=1
		end
		if data_type=='string' && flag==0
			match=data.match(/^#{regexp}+$/)
			if match
				msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
			else
				msg='<td style="color:blue">row:'+"#{row},"+'column:'+"#{column}   "+"not require,but wrong pattern.expected regex #{regexp}"+'</td>'
			end
		end
		if data_type=='number' && flag==0
			match=data.match(/^#{regexp}+$/)
			if match
				msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
			else
				msg='<td style="color:blue">row:'+"#{row},"+'column:'+"#{column}   "+"not require,but wrong pattern.expected regex #{regexp}"+'</td>'
			end
		end
		if data_type=='date' && flag==0
			if /dd-mm-yyyy/=~regexp 
				date_type=1
			end
			if /mm-dd-yyyy/=~regexp 
				date_type=2
			end
			if /\d\d-\d\d-\d\d\d\d/=~data
				flag_date=1
				a=data.split("-")
				if date_type==1
				dt=a[0].to_i
				mn=a[1].to_i
				end
				if date_type==2
				dt=a[1].to_i
				mn=a[0].to_i
				end
				yr=a[2].to_i
				if mn==1||mn==3||mn==5||mn==7||mn==8||mn==10||mn==12
					if dt<=31 && dt!=0
						msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
					else
						msg='<td style="color:blue">row:'+"#{row},"+'column:'+"#{column}   "+'not require,but wrong date</td>'
					end
				end
				if mn==4||mn==6||mn==9||mn==11
					if dt<=30 && dt!=0
						msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
					else
						msg='<td style="color:blue">row:'+"#{row},"+'column:'+"#{column}   "+'not require,but wrong date</td>'
					end
				end
				if mn==2
					if dt<=29 && dt!=0 && (yr%4)==0
						print "date"
					elsif dt<=28 && dt!=0 && (yr%4)!=0
						msg='<td>row:'+"#{row},"+'column:'+"#{column}   "+'accepted</td>'
					else 
						msg='<td style="color:blue">row:'+"#{row},"+'column:'+"#{column}   "+'not require,but wrong date</td>'
					end
				end
				if mn>12
					msg='<td style="color:blue">row:'+"#{row},"+'column:'+"#{column}   "+'not require,but wrong month</td>'
				end
			end
			if flag_date==0
				msg='<td style="color:blue">row:'+"#{row},"+'column:'+"#{column}"+"not require,wrong pattern.<br>expected regex #{regexp}"+'</td>'
			end
		end
	end
	
	if column==1
		msg="</tr>"+"#{msg}"
	end
	if column==3
		msg="#{msg}"+"</tr>"
	end
	return msg
 end