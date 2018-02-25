require 'octokit'


module GitBlog
  module Application
    module Services
      class LoadPostsForIndex
        def perform
          octokit = Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN'))
          latest_commit_sha = octokit.ref(
            GitBlog.configuration.github_repo,
            'heads/master'
          )[:object][:sha]
          tree = octokit.tree(
            GitBlog.configuration.github_repo,
            latest_commit_sha,
            recursive: true
          )[:tree]
          archive_posts = tree.select do |item|
            # Is a directory
            item[:type] == 'blob' &&
              # Directory name is a four-digit year that starts with '19' or '20'
              # with a subdirectory with a name that's a two-digit month number
              /(19|20)\d\d\/(0[1-9]|1[0-2])/.match?(item[:path])
          end
        end
      end
    end
  end
end
