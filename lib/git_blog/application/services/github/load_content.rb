require 'octokit'

module GitBlog
  module Application
    module Services
      module GitHub
        class LoadContent
          def initialize(filepath)
            @filepath = filepath
            @octokit = Octokit::Client.new
          end

          def perform
            Logger.new($stdout).debug "Loading #{@filepath.join} from " \
              "#{GitBlog.configuration.github_repo}"
            @octokit.contents GitBlog.configuration.github_repo,
                accept: 'application/vnd.github.v3.raw',
              path: @filepath.join
          rescue Octokit::NotFound => e
            e.message
          end
        end
      end
    end
  end
end
