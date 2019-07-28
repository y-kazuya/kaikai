
# json.array! @datas do |data|

#   json.date       data[:date]
#   json.number       data[:number]
# end


json.records do
  json.array! @numbers
end

json.dates do
  json.array! @dates
end

json.check @check