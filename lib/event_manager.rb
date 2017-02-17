require 'csv'

puts "EventManager Initialized"

contents = CSV.open "./event_attendees.csv", headers: true, header_converters: :symbol

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

contents.each do |line|
  zip = clean_zipcode(line[:zipcode])
  name = line[:first_name]
  puts "#{name} lives in the #{zip}"
end
