require 'haml'
require 'sinatra'
require 'openlibrary'

helpers do

    def get_book_reference(isbn)
        api        = Openlibrary::Data
        book       = api.find_by_isbn(isbn)
        title      = book.title
        year       = /\d\d\d\d/.match(book.publish_date)
        publishers = book.publishers
        authors    = book.authors

        # Build up reference
        reference = ""
         
        # Author(s)
        authors.each do |author|
            reference << "#{ author["name"] }, "
        end

        # Year of publication
        reference << "#{ year }. "
          
        # Title
        reference << italicise(title) << ". "

        # Publisher(s)
        count = publishers.length
        publishers.each do |publisher|
            punctuation = count > 1 ? "," : "."
            reference << "%s%s" % [publisher["name"], punctuation]
            count -= 1
        end

        return reference
    end

    def italicise(text)
        return "<em>#{ text }</em>"
    end

end

get '/' do
    haml :index
end

post '/result' do
    input = params[:raw_list].split("\n")
    
    # Removes any empty elements in array
    isbns = input.reject { |x| x.strip.length == 0 }

    # Get references
    @references = ""
    isbns.each do |isbn|
        @references << get_book_reference(isbn.strip) << "\n"
    end
    
    haml :result
end

