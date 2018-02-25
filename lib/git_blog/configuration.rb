module GitBlog
  class Configuration
    # The full name of the GitHub repo, e.g. username/repo_name
    attr_accessor :github_repo

    # The URL with protocol of the git repo.
    # Use file://path/to/repo for local repo.
    attr_accessor :git_url
  end

  def self.configuration
    @_configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
