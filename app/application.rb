require "pry"
class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
# binding.pry
    if req.path.match(/items/)
      name = req.path.split("/items/").last
      found = Item.all.find {|i| i.name == name}
        if found
          resp.write found.price
        else
          resp.write "Item not found"
          resp.status =400
        end
    else
      resp.write "Route not found"
      resp.status =404
    end
    resp.finish
  end
end
