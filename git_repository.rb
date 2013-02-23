class GitRepository
	def initialize(hash = {})
		@system_wrapper = hash[:system] || SystemWrapper.new
		@remote = hash[:remote] || 'origin'
		@ssh_repository = hash[:ssh_repository]
	end
	def commit(hash)
		message_with_options = insert_options(:message => "git commit", :options=>hash[:options])
		commit_message = "#{message_with_options} -m '#{hash[:message]}'"
		@system_wrapper.execute(commit_message)
	end

	def has_changes?
		git_status = @system_wrapper.execute("git status")
		result = git_status.include?("Changes not staged for commit") || git_status.include?("Changes to be committed:")
		return result
	end

	def has_untracked?
		git_status = @system_wrapper.execute("git status")
		result = git_status.include?("Untracked files:")
		return result
	end

	def push(hash = {})
		branch = hash[:branch] || 'master'
		repository = "--repo='#{@ssh_repository}'" unless @ssh_repository.nil?
		location = repository || @remote
		message_with_options = insert_options(:message => "git push", :options => hash[:options])
		push_message = "#{message_with_options} #{location} #{branch}"
		@system_wrapper.execute(push_message)
	end

	private
	def insert_options(hash)
		if(hash[:options].nil?)
			return "#{hash[:message]}"
		else
			return "#{hash[:message]} #{hash[:options]}"
		end
	end
end


class SystemWrapper
	def execute(command)
		result = `#{command}`
		return result
	end
end
