require 'sinatra'
require 'json'
require 'net/http'
require 'openlibrary'

get '/' do
    haml :index
end

post '/result' do
    input = params[:raw_list].split("\n")
    
    # removes any empty elements in array
    isbns = input.reject { |x| x.strip.length == 0 }

    details = Openlibrary::Data
    @titles = []
    @dates = []
    @publishers = []
    @authors = []

    isbns.each do |isbn|
        book = details.find_by_isbn(isbn.strip)
        @titles << book.title
        @dates << book.publish_date
        @publishers << book.publishers[0]["name"]
        @authors << book.authors[0]["name"]
     end

     @however_many = @titles.length - 1
    erb :result
end
