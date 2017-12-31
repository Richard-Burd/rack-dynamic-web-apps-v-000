class MyProgram

  @@books = ["Sefer", "Orayisah", "Mechilta"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    resp.write "\nHere's what I have today!\n"

    if req.path.match(/books/)
      @@books.map do |item|
        resp.write "\n#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]

      if @@books.include?(search_term)
        resp.write "\n#{search_term} is available today!"
      else
        resp.write "\nCouldn't find #{search_term}"
      end
    end

    resp.finish
  end
end
