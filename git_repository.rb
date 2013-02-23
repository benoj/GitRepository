class GitRepository
	def initialize(hash = {})
		@system_wrapper = hash[:system] if hash.has_key?(:system)
		@remote = hash[:remote] || 'origin'
		@ssh_repository = hash[:ssh_repository]
	end
	def commit(hash)
		if hash.has_key?(:options)
			commit_message = "git commit #{hash[:options]} -m '#{hash[:message]}'"
		else
			commit_message = "git commit -m '#{hash[:message]}'"
		end
		@system_wrapper.execute(commit_message)
	end

	def push(hash = {})
		branch = hash[:branch] || 'master'
		repository = "--repo='#{@ssh_repository}'" unless @ssh_repository.nil?
		location = repository || @remote
		@system_wrapper.execute("git push #{location} #{branch}")
	end
end
