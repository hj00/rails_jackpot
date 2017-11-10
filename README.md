# 2017.11.10 5일차

workspace주소/rails/db : db확인

# 로또 번호 가져와서 당첨여부 확인 페이지

- controller : lotto

- lotto#index : 루트페이지

-  lotto#index : 버튼(로또번호추천)

-  lotto#show : 로또번호추천

-  lotto#api : 로또번호를 가져와서, array에 넣는다

   ```ruby
   def api
     lotto = 
     Httparty.get()
     JSON.parse()
     arr = [] #해당정보를 어떤 배열에 넣어준다. 
     
     "lotto 담긴 숫자와 arr안에 담긴 숫자를 비교"
      - 6개 다 맞으면 1등
      - 5개 맞으면 2등
      - 4개 맞으면 3등 .... 1개 맞으면 6등
   end
   ```

   ```ruby
   #배열 넣기
   require 'httparty'
   require 'nokogiri'
   require 'json'

   url = 'http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo='
   response = HTTParty.get(url)
   # response.parsed_response
   party_json = JSON.parse(response.body)

   # 1. Hard coding
   arr = Array.new

   arr[0] = party_json["drwtNo1"]
   arr[1] = party_json["drwtNo2"]
   arr[2] = party_json["drwtNo3"]
   arr[3] = party_json["drwtNo4"]
   arr[4] = party_json["drwtNo5"]
   arr[5] = party_json["drwtNo6"]
   p arr

   # 2. 간소화
   arr = Array.new
   6.times do |i|
       arr << result["drwtNo#{i+1}"]
   end
   p arr

   # 3. Code
   arr = Array.new
   party_json.each do |key, value|
     if key.include? "drwtNo"
       arr << value
     end
   end
   p arr.sort

   # 간략화↓↓↓
   arr = Array.new
   party_json.each do |key, value|
     arr << value if key.include? "drwtNo"
   end

   #4. Self Code
   require 'httparty'
   require 'nokogiri'
   require 'json'

   url = 'http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo='
   response = HTTParty.get(url)
   # response.parsed_response
   party_json = JSON.parse(response.body)

   num = Array.new
   party_json.each do |id|
       if id[0].include? 'drwtNo'
           num << id[1]
       end
   end
   p num
   ```

   ```ruby
   # 추천받은 번호와 당첨번호 비교
   lotto = (1..45).to_a.sample(6)

   matcing = arr & lotto

   # 1. Hard Coding
   if matching.count == 6
     result = "1등"
   elsif matching.count == 5
     result = "2등"
   elsif matching.count == 4
     result = "3등"
   elsif matching.count == 3
     result = "4등"
   elsif matching.count == 2
     result = "5등"
   elsif matching.count == 1
     result = "6등"
   end

   # bonusNo포함
   bonus = party_json["bnusNo"]
   matching = arr & lotto
   if matching.count == 6
     result = "1등(15억)"
   elsif matching.count == 5 && lotto.include?(bonus)#plus 포함해서 (우리 추천 번호에 bonus가 있니?)
     result = "2등(4천만원)"
   elsif matching.count == 5
     result = "3등(120만원)"
   elsif matching.count == 4
     result = "4등(5만원)"
   elsif matching.count == 3
     result = "5등(5천원)"
   elsif matching.count == 2
     result = "꽝"
   elsif matching.count == 1
     result = "꽝"
   end
   ```

   ​

```ruby
rails g controller lotto index show
```

 - index.erb

```html
<form></form>
```
 - lotto_controller.rb : 로또 번호 추천 로직 넣기

```ruby
def show
  @lotto = 로또 추천코드
end
```
 - show.erb : 로또 번호 추천 결과를 보여주기.