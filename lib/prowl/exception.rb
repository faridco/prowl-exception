require 'prowl/rack'

module ProwlException
  class Railtie < ::Rails::Railtie
    initializer "prowlexception.middleware" do |app|
      app.middleware.use Rack::ProwlException
    end
  end
end
