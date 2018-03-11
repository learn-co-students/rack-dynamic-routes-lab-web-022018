require_relative 'item'

class Application
  @@items = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match('/items/')

      item_searched = req.path.split("/items/").last
      item_match = @@items.select {|item| item.name == item_searched}

      if item_match.first
        resp.write "#{item_match.first.price}"
        resp.status = 200
      else
        resp.write "Item not found."
        resp.status = 400
      end

    else
      resp.write "Route not found."
      resp.status = 404
    end

    resp.finish
  end
end
