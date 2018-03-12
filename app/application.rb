require 'pry'

class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      path_item = req.path.split("/items/").last
      found_item = @@items.find {|listed_item| listed_item.name == path_item}
      binding.pry
      if found_item == nil
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write found_item.price
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
