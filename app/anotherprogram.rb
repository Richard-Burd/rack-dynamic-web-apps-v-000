class File
  attr_accessor :number, :source
  def initialize(number, source)
    @number = number
    @source = source
  end
end

class Protocol

  @@files = [File.new("34", "Dept. of Energy"), File.new("12", "DoD")]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/files/)
      resp.write "Here are the Files:"

      @@files.map do |x|
        resp.write "\n#{x.number} - #{x.source}"
      end

    elsif req.path == "/file/34"
      resp.write @@files[0].number
    elsif req.path == "/file/12"
      resp.write "Sorry but #{@@files[1].number} is currently down."

    else
      resp.write "Files not found anywhere! :("
    end
    resp.finish
  end
end
