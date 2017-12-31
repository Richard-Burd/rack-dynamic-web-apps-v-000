require 'pry'
=begin
class Application

  def call(env)
    resp = Rack::Response.new

    num_1 = Kernel.rand(1..3)
    num_2 = Kernel.rand(1..3)
#   num_3 = Kernel.rand(1..20)

    resp.write "#{num_1}\n"
    resp.write "#{num_2}\n"
#   resp.write "#{num_3}\n"

    if num_1 == num_2 # && num_2 == num_3
      resp.write "You Win"
    else
      resp.write "You Lose"
    end
    resp.finish # The response isn't sent back to the user until #finish is called.
  end
end
=end


class Application

  @@fruits = ["Apples","Carrots","Pears"]
  @@single_fruits = @@fruits.map {|x| x[0...-1]}

  @@items = ["hose", "pipe", "hammer", "can"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/fruits/)      #Rack has a method called "path" that will return the path that was requested.
      @@fruits.each do |fruit|
        resp.write "#{fruit}\n"
      end
    elsif req.path.match(/veggiez/)
      resp.write "Tomatoes & Potatoes"

    elsif req.path.match(/search/)   #http://165.227.31.156:45385/search?q=Apple
      zearch_term = req.params["q"]  #the "q" can be changed to anything but I think it is a convention.
                                     # "search_term" can be named anything you want like "zearch_term"
      if @@items.include?(zearch_term)
        resp.write "#{zearch_term} is one of our thingamagigs"
      elsif @@fruits.include?(zearch_term)
        resp.write "'#{zearch_term}' is a valid fruit!"
        resp.write "\n\n#{zearch_term} just happens to be a #{zearch_term.class}"
      elsif @@single_fruits.include?(zearch_term)
        resp.write "\n'#{zearch_term}' is a valid fruit!"
      else
        resp.write "Couldn't find #{zearch_term}"
      end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
end

=begin
class Song
  attr_accessor :title, :artist
  def initialize(title, artist)
    @title = title
    @artist = artist
  end
end

class Application

  @@songs = [Song.new("Sorry", "Justin Bieber"),
            Song.new("Hello","Adele")]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/songs/)
                 # req.path                       => "/songs/Sorry"
                 # req.path.split                 => ["/songs/Sorry"]
                 # req.path.split("/songs/")      => ["", "Sorry"]
                 # req.path.split("/songs/").last => "Sorry"
      song_title = req.path.split("/songs/").last #turn /songs/Sorry" into "Sorry"
      # binding.pry
      song = @@songs.find{|s| s.title == song_title}

      resp.write song.artist
      resp.write "\n\n"
      resp.write song.title
    end

    resp.finish
  end
end
=end
