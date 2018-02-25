require 'commonmarker'
require 'slim'
require_relative 'services/github/load_content'
require_relative 'services/load_posts_for_index'

module GitBlog
  module Application
    module Routes
      class << self
        def registered(app)
          app.get '/favicon.ico' do; end

          app.get '/' do
            @posts = ::GitBlog::Application::ViewModels::IndexView.new.perform
            slim :index
          end

          app.get '/*' do
            @post = GitBlog::Application::Models::Post.new
            content = GitBlog::Application::Services::GitHub::LoadContent.
              new(params['splat']).
              perform
            @post.body = CommonMarker.render_html(content)
            @post.title = params[:filename]

            slim :post
          end
        end
      end
    end
  end
end
