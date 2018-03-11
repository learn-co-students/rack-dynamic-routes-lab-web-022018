class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match("/items/")
      item = req.path.split("/").last
      all = @@items.find{|i| i.name == item}
      if all == nil
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write "#{all.price}"
      end
    else
      resp.write("Route not found")
      resp.status = 404
    end
    resp.finish
  end
end
