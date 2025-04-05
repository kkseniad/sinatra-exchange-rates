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

get("/:from_currency") do
  
  @original_currency = params.fetch("from_currency")

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

   erb(:from)

end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

  #Use HTTP.get to retrieve the API data
  @raw_response = HTTP.get(api_url)

  #Get the body of the response as a string
  @raw_string = @raw_response.to_s
   
  #Convert the string to JSON
  @parsed_data = JSON.parse(@raw_string)

  @result = @parsed_data.fetch("result")
  
  erb(:from_to)
end
