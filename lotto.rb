require 'httparty'
require 'nokogiri'
require 'json'

url = 'http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo='
response = HTTParty.get(url)
# response.parsed_response
party_json = JSON.parse(response.body)

lotto = (1..45).to_a.sample(6)
p lotto
arr = Array.new

party_json.each do |key, value|
  arr << value if key.include? "drwtNo"
end
p arr

count = (lotto & arr).count
rank = (6 - count) + 1
unless rank > 4
p rank

# rank 
# 6 - 6 = 0 1
# 6 - 5 = 1 2
# 6 - 4 = 2 3
# 6 - 3 = 3 4
# 6 - 2 = 4 꽝
# 6 - 1 = 5 꽝
# 6 - 0 = 6 꽝

# arr[0] = party_json["drwtNo1"]
# arr[1] = party_json["drwtNo2"]
# arr[2] = party_json["drwtNo3"]
# arr[3] = party_json["drwtNo4"]
# arr[4] = party_json["drwtNo5"]
# arr[5] = party_json["drwtNo6"]
#--------------------------------
# 6.times do |i|
#     arr << result["drwtNo#{i+1}"]
# end
# p arr
#-------------------------------
# num = Array.new
# party_json.each do |id|
#     if id[0].include? 'drwtNo'
#         num << id[1]
#     end
# end
# p num
