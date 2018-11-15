require 'sinatra/base'

class Birthday < Sinatra::Base
  run! if app_file == $0

  # not sure why but needed this https://stackoverflow.com/questions/18844863/sinatra-clears-session-on-post
  use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'your_secret'

  get '/' do
    erb :index
  end

  post '/calc' do
    @birthdate = params[:birthdate].split("-")
    session[:name] = params[:name]
    t = Time.now
    bday = Time.new(t.year, @birthdate[1], @birthdate[2])
    if t.day == @birthdate[2].to_i && t.month == @birthdate[1].to_i
      redirect '/happy'
    else
      if t - bday > 1
        bday = Time.new((t.year)+1, @birthdate[1], @birthdate[2])
        session[:diff] = (((bday - t) / 60 / 60 / 24)+1).to_i
      else
        session[:diff] = (((bday - t) / 60 / 60 / 24)+1).to_i
      end
      redirect '/soon'
    end
  end

  get '/happy' do
    erb :happy
  end

  get '/soon' do
    erb :soon
  end

end
