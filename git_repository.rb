class GitRepository
	def initialize(hash = {})
		@system_wrapper = hash[:system] || SystemWrapper.new
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

	def has_changes?
		git_status = @system_wrapper.execute("git status")
		result = git_status.include?("Changes not staged for commit")
		puts result
		return result
	end

	def push(hash = {})
		branch = hash[:branch] || 'master'
		repository = "--repo='#{@ssh_repository}'" unless @ssh_repository.nil?
		location = repository || @remote

	if hash.has_key?(:options)
			push_message = "git push #{hash[:options]} #{location} #{branch}"
		else
			push_message = "git push #{location} #{branch}"
		end
		@system_wrapper.execute(push_message)
	end
end


class SystemWrapper
	def execute(command)
		result = `#{command}`
		puts result
		return result
	end
end
