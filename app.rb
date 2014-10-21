require 'rack'

app = Proc.new do |env|
  rails_insance = Rails.new(env)
  response = rails_insance.dispatch!
  if response.is_a?(Array) && response.length == 3
    response
  else
    rails_insance.render 'Unknow Exception', status: 500
  end
end


class Rails

  attr_accessor :env

  ROUTES = {
    '/' => 'home#index',
    '/my' => 'my#index'
  }

  def initialize(env)
    @env = env
  end

  def dispatch!
    return render '404 Not found', status: 404 unless request_path

    controller_name, action = normalize_controller_action_map
    begin
      controller_class = Object.const_get(controller_name)
      controller = controller_class.new(env)
      controller.send(action)
    rescue Exception => e
      render "Not found Controller: #{controller_name}", status: 500
    end
  end

  def request_path
    @request_path ||= ROUTES[env['PATH_INFO']]
  end

  def normalize_controller_action_map
    segments = request_path.split('/')

    controller, action = segments.pop.split('#')

    namespaces = segments.map(&:capitalize).join('::')

    controller_class = "#{controller.capitalize}Controller"

    controller_class = "#{namespaces}::#{controller_class}" unless namespaces.empty?

    [controller_class, action]
  end

  def render(body, status: 200, content_type: 'text/html')
    [status, {'Content-Type' => content_type}, [body]]
  end
end

module ActionController
  class Base
    attr_accessor :env

    def initialize(env)
      @env = env
    end

    def render(body, status: 200, content_type: 'text/html')
      [status, {'Content-Type' => content_type}, [body]]
    end
  end
end

class HomeController < ActionController::Base
  # GET /
  def index
    render 'Helloworld'
  end
end

class MyController < ActionController::Base
  # GET /my
  def index
    render 'This is my page'
  end
end

Rack::Handler::WEBrick.run app
