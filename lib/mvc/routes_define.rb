module Mvc
  class RoutesDefine

    attr_reader :static_map, :dynamic_map

    def initialize
      @static_map = { get: {}, post: {}, put: {}, patch: {}, delete: {} }
      @dynamic_map = { get: [], post: [], put: [], patch: [], delete: [] }
    end

    def self.routes(&block)
      @@routes ||= new
      @@routes.instance_eval(&block) if block_given?
      @@routes
    end

    def self.routing_table
      @@routes
    end

    [:get, :post, :put, :patch, :delete].each do |action|
      define_method action do |path, to: nil|
        define_routes(action, path, to: to)
      end
    end

    private

    def define_routes(action, path, to: nil)
      if path.is_a?(String) || path.is_a?(Symbol)
        controller_class, action_name = if to.nil?
          normalize_controller_and_action_from_path(path)
        else
          normalize_controller_and_action_from_to(to)
        end
        @static_map[action][path] = { controller_class: controller_class, action_name: action_name }
      elsif path.is_a?(Regexp)
        if to.nil?
          raise CommonError, "regexp routes should have specific controller#action, ex: post#index" 
        else
          # TODO: 
        end
      else
        raise CommonError, "path only support string, symbol or regexp"
      end
    end

    def normalize_controller_and_action_from_path(path)
      segments = path.split('/')
      action_name = segments.pop
      namespaces = segments.map(&:capitalize).join('::')

      controller_class = if namespaces.empty? then "#{namespaces}Controller" else "HomeController" end

      [controller_class, action_name]
    end

    def normalize_controller_and_action_from_to(to)
      segments = to.split('/')
      controller, action_name = segments.pop.split('#')
      namespaces = segments.map(&:capitalize).join('::')
      controller_class = "#{controller.capitalize}Controller"

      controller_class = "#{namespaces}::#{controller_class}" unless namespaces.empty?

      [controller_class, action_name]
    end
  end
end