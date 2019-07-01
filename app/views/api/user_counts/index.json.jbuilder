
json.array! @sum do |s|
  json.title       s[:title]
  json.start       s[:start].strftime("20%y-%m-%d")
  json.className   s[:class_name]
end
