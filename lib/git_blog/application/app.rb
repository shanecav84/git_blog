require 'sinatra'

Dir.glob(File.dirname(__FILE__) + '/{models,services,view_models}/**/*.rb').each { |file| require file }
require_relative './routes'

GitBlog.configure do |c|
  c.github_repo = ENV.fetch('GITHUB_REPO')
end

module GitBlog
  module Application
    class App < ::Sinatra::Base
      enable :logging
      register ::GitBlog::Application::Routes

      def self.root
        ::Pathname.new(File.expand_path File.dirname(__FILE__))
      end
    end
  end
end
