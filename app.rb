require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"

#Homepage route
get("/") do
  
  #Get the data from list 
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  #Use HTTP.get to retrieve the API data
  @raw_response = HTTP.get(api_url)

  #Get the body of the response as a string
  @raw_string = @raw_response.to_s

  #Convert the string to JSON
  @parsed_data = JSON.parse(@raw_string)

  currencies = @parsed_data.fetch("currencies")

  @list_currency = []

  currencies.each do |key, value|
    @list_currency.push(key)
  end


  #Render a view template
  erb(:homepage)
  

end
