class GitRepository
	def initialize(hash)
		@system_wrapper = hash[:system] if hash.has_key?(:system)
		if hash.has_key?(:remote)
			@remote = hash[:remote] 
		else
			@remote = "origin"
		end
	end
	def commit(hash)
		if hash.has_key?(:options)
			commit_message = "git commit #{hash[:options]} -m '#{hash[:message]}'"
		else
			commit_message = "git commit -m '#{hash[:message]}'"
		end
		@system_wrapper.execute(commit_message)
	end

	def push()
		@system_wrapper.execute("git push #{@remote} master")
	end
end
