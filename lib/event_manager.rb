require 'pry'
require 'csv'
require 'erb'
require 'time'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(attendee_id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")
  filename = "output/thanks_#{attendee_id}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(phone)
    phone.gsub!(/[^\d]/, "")
    number = "invalid_number"
    number = phone if phone.length == 10
    number = phone.slice(1..10) if phone.length == 11 && phone[0] == 1
    number
end


puts "EventManager Initialized"

contents = CSV.open "./event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

def format_time(date_time)
  formatted = date_time.gsub("/", "-")
  Date.strptime(formatted, '%B %d, %Y %H:%M')
  # "11/25/08 19:21"

end


def busiest_registration_hour(array)
  registration_times = {}
  array.each do |time|
    hour = time.split[1].split(":")[0] + ":00"
    if registration_times.has_key?(hour)
      registration_times[hour] += 1
    else
      registration_times[hour] = 1
    end
  end
  hours_by_registration = registration_times.sort_by{|key, value| value}.reverse!
  puts "the busiest registration times were:"
  puts "#{hours_by_registration}"
end

def busiest_day_of_week(array)
  registration_days = {}

  days = []
  array.map do |time|
    binding.pry
    formatted = time.gsub("/", "-").split[0]
    day = Time.parse(formatted).strftime("%A")
    puts day
    days.push(day)
  end
  days
end


date_times = []

contents.each do |line|
#   attendee_id = line[0]
#   name = line[:first_name]
    date_times.push(line[:regdate])
#   phone_number = clean_phone_number(line[:homephone])
#   zip = clean_zipcode(line[:zipcode])
#   legislators = legislators_by_zipcode(zip)
#   form_letter = erb_template.result(binding)
#   save_thank_you_letters(attendee_id, form_letter)
end
busiest_registration_hour(date_times)
busiest_day_of_week(date_times)

# def peak_registration_hours
#
#   hours.sort
# # date = Time.parse(registration_time).strftime("%B %d, %Y")
# # hour = Time.parse(registration_time).strftime("%k:%M")
# end
