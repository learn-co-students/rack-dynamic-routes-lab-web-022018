class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
     if req.path.match (/items/)
       i = req.path.split("/items/").last
       if itm = @@items.find {|item| item.name == i}
         resp.write itm.price
       else
         resp.status = 400
         resp.write "Item not found"
     end
     else
       resp.status = 404
       resp.write "Route not found"
     end
     resp.finish
   end
 end
