require 'open-uri'
require 'csv'

#Get info about specific stocks
def get_info stock_symbol
  puts "#{stock_symbol} Current Ticker Information"
  url = "http://download.finance.yahoo.com/d/quotes.csv?s=#{stock_symbol}&f=sl1d1t1c1ohgv&e=.csv"
  puts "Connecting to #{url}\n\n\n"

  csv = CSV.parse(open(url).read)

  #parse csv data
  csv.each do |row|
    puts "--------------------------------------------------"
    puts "Information current as of #{row[3]} on #{row[2]}\n\n"
    puts "#{row[0]}'s last trade was - $#{row[1]}  (increase of #{row[4]})\n\n"
    puts "\tOpened at $#{row[5]}"
    puts "\tRange for the day $#{row[7]} - $#{row[6]}"
  end
  puts "--------------------------------------------------"
end


print "Enter stock symbol (separate by space if > 1): "
stock_symbols = gets.upcase

#Get stock information
stock_symbols.split.each do |symbol|
  get_info(symbol)
end
