class LottoController < ApplicationController
  def index
  end

  def show
    @lotto = (1..45).to_a.sample(6)
  end
  
  def api
    require 'json'
    url = 'http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=4'
    response = HTTParty.get(url)
    # response.parsed_response
    party_json = JSON.parse(response.body)
    
    @arr = Array.new
    party_json.each do |key, value|
      @arr << value if key.include? "drwtNo"
    end
    
    @lotto = (1..45).to_a.sample(6)
    # @lotto = [30, 27, 14, 42, 40, 31] # 테스트 코드
    @matching = @arr & @lotto
    @bonus = party_json["bnusNo"]
    
    if @matching.count == 6
      @result = "1등(15억)"
    elsif @matching.count == 5 && lotto.include?(@bonus)#plus 포함해서 (우리 추천 번호에 bonus가 있니?)
      @result = "2등(4천만원)"
    elsif @matching.count == 5
      @result = "3등(120만원)"
    elsif @matching.count == 4
      @result = "4등(5만원)"
    elsif @matching.count == 3
      @result = "5등(5천원)"
    elsif @matching.count == 2
      @result = "꽝"
    elsif @matching.count == 1
      @result = "꽝"
    end
  end
    
end
