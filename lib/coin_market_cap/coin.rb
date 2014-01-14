module CoinMarketCap

	# Coin class
  class Coin
		attr_accessor :coin

    def initialize(coin)
      @coin = coin.downcase
    end

    def sample_message
      "Hello, World!"
    end

		def price
			coin_price = fetch_coin_price(@coin)
			coin_price
		end

		private

		def fetch_coin_price(coin)
			doc = Nokogiri::HTML(open("http://www.coinmarketcap.com"))
			currencies = {}

			doc.css("#currencies tbody tr").each do |coin|
				currency = coin.css(".no-wrap.currency-name a").text.downcase
				price = coin.css("td[4] a").text.gsub(/[^0-9\,\.]/, "").to_f
				#fail if price.nil?
				currencies[currency] = price
			end

			currencies[coin]
		end

  end
end

