describe Mvc::RoutesDefine do
  
  it "#new should create an empty #static_map, #dynamic_map" do
    routes = Mvc::RoutesDefine.new  
    expect(routes.static_map).to be_a_kind_of Hash
    expect(routes.dynamic_map).to be_a_kind_of Hash
  end

  it "#routes should always get same routes" do
    expect(Mvc::RoutesDefine.routes).to be Mvc::RoutesDefine.routes
  end

  context "When define static routing" do
    before(:all) {
      Mvc::RoutesDefine.routes.instance_eval { @routes = nil }
      Mvc::RoutesDefine.routes do
        get '/api/posts', to: 'api/posts#index'
        post '/api/posts', to: 'api/posts#create'
      end
    }

    let(:static_map) { Mvc::RoutesDefine.routes.static_map }

    it "should have GET /api/posts to Api::PostsController#index" do
      expect(static_map[:get]['/api/posts'][:controller_class]).to eq 'Api::PostsController'
      expect(static_map[:get]['/api/posts'][:action_name]).to eq 'index'
    end

    it "should have POST /api/posts to Api::PostsController#create" do
      expect(static_map[:post]['/api/posts'][:controller_class]).to eq 'Api::PostsController'
      expect(static_map[:post]['/api/posts'][:action_name]).to eq 'create'
    end
  end
end