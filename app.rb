require 'sinatra/base'

class Birthday < Sinatra::Base
  run! if app_file == $0

  get '/' do
    erb :index
  end

  post '/calc' do
    @birthdate = params[:birthdate]
    @name = params[:name]
    puts @birthdate
    puts @name
    
  end

end
