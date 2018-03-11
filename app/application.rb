class Application

  def call(env)
    resp=Rack::Response.new
    req=Rack::Request.new(env)
     # Your application should only accept the /items/<ITEM NAME> route.
    if req.path.match(/items/)
      # If a user requests /items/<Item Name> it should return the price of that item
      item_requested = req.path.split("/items/").last
      item_price = nil
      # STDERR.puts "********#{item_requested}"
      # STDERR.puts "********#{Item.all}"
      Item.all.each {|item| item_price = item.price if item.name==item_requested}
      if item_price
        resp.write "The price of #{item_requested} is #{item_price}"
      else
      # IF a user requests an item that you don't have, then return a 400 and an error message
        resp.status=400
        resp.write "Item not found"
      end
    else #path didnt patch /item/   Everything else should 404
      resp.write "Route not found"
      resp.status = 404
    end # match path /items/
    resp.finish
  end #def call
end #class
