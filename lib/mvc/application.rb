module Mvc
  class Application
    def call(env)
      [ 200, {"Content-Type" => "text/html"}, [RoutesDefine.routing_table.inspect] ]
    end
  end
end