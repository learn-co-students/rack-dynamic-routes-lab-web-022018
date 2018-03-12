class Application

  @@items = [Item.new("Matt", 250), Item.new("Bob", 150)]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      if item =@@items.find do |x| x.name == item_name end
        resp.write item.price
      else 
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status=404
      resp.write "Route not found"
    end
    resp.finish
  end
end