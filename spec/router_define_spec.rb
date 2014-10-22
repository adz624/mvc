describe Mvc::RoutesDefine do
  
  it "#new should create an empty #static_map, #dynamic_map" do
    routes = Mvc::RoutesDefine.new  
    expect(routes.static_map).to be_a_kind_of Hash
    expect(routes.dynamic_map).to be_a_kind_of Hash
  end

  it "#routes should always get same routes" do
    expect(Mvc::RoutesDefine.routes).to be Mvc::RoutesDefine.routes
  end
end