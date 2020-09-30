
require 'nokogiri'
require 'open-uri'
require 'byebug'
require 'mechanize'
require 'json'

url = 'http://localhost:4567/'

loop do

  html = open(url)
  doc = Nokogiri::HTML(html)

  doc.css('.data').each do |document|

    @price_1 = document.css('.data_p1').text.split(':').map(&:strip).last
    @price_2 = document.css('.data_p2').text.split(':').map(&:strip).last
    @price_3 = document.css('.data_p3').text.split(':').map(&:strip).last

  end

  data = File.open 'parse_data.json', 'w' do |d|
    d.write(
      "[\n",
      "  {\n",
      "    \"price_1\": #{@price_1},\n",
      "    \"price_2\": #{@price_2},\n",
      "    \"price_3\": #{@price_3}\n",
      "  }\n",
      "]"
    )
  end

  sleep 1800

end
