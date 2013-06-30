require 'haml'
require 'sinatra'
require 'openlibrary'

get '/' do
    haml :index
end

post '/result' do
    input = params[:raw_list].split("\n")
    
    # removes any empty elements in array
    @isbns = input.reject { |x| x.strip.length == 0 }
    
    @details = Openlibrary::Data
    haml :result
end
