module Mvc

  autoload :Application, 'mvc/application'
  autoload :RoutesDefine, 'mvc/routes_define'

  CommonError = Class.new(StandardError)

  def self.application
    @application ||= Application.new
  end
end

Mvc::RoutesDefine.routes do
  get '/', to: 'api/posts#index'
end