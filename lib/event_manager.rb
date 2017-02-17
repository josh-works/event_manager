require 'pry'
require 'csv'

puts "EventManager Initialized"

contents = CSV.open "./event_attendees.csv", headers: true, header_converters: :symbol

contents.each do |line|
  zip = line[:zipcode].to_s
  if zip.length <= 5
    zip = zip.rjust(5, "0")
  elsif zip.length > 5
    zip = zip.slice(0..4)
  end
  name = line[:first_name]
  puts "#{name} lives in the #{zip}"
end


# csv = File.open("./event_attendees.csv", "r").read.split("\n")
#
# puts csv


# sample data
# ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode
# 1,11/12/08 10:47,Allison,Nguyen,arannon@jumpstartlab.com,6154385000,3155 19th St NW,Washington,DC,20010
# 2,11/12/08 13:23,SArah,Hankins,pinalevitsky@jumpstartlab.com,414-520-5000,2022 15th Street NW,Washington,DC,20009
# 3,11/12/08 13:30,Sarah,Xx,lqrm4462@jumpstartlab.com,(941)979-2000,4175 3rd Street North,Saint Petersburg,FL,33703
