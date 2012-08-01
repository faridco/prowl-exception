require 'rack'
require 'prowler'

module Rack
  class ProwlException

    def initialize app
      @app = app
      @template = ERB.new(TEMPLATE)
    end

    def call(env)
      begin
        body = @app.call(env)
      rescue => boom
        send_prowl_notification boom, env
        raise
      end

      body
    end

    private
    
    def send_prowl_notification exception, env
      request = Rack::Request.new env 
      Prowler.notify exception.class.to_s, @template.result(binding)
    end

    TEMPLATE = (<<-'BODY').gsub(/^ {4}/, '')
    A <%= exception.class.to_s %> occured: <%= exception.to_s %>

    <%= request.respond_to?(:remote_ip) ? request.remote_ip : request.ip %> => <%= request.request_method %> <%= request.respond_to?(:url) ? request.url : "#{request.protocol}#{request.host}#{request.request_uri}" %> => <%= env['action_controller.instance'].class.to_s %>#<%= request.respond_to?(:parameters) ? request.parameters['action'] : request.params['action'] %> with <%= request.respond_to?(:parameters) ? request.parameters : request.params %>
    <%= request.env.select{|k,v| k.start_with? 'HTTP' }.map{|k,v| "#{k} => #{v}" }.join("\n") %>
    <% if exception.respond_to?(:backtrace) %>
    <%= exception.backtrace.take(5).join("\n") %>
    <% end %>
    BODY

  end
end
