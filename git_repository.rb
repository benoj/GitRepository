class GitRepository
	def initialize(hash)
		@system_wrapper = hash[:system] if hash.has_key?(:system)
	end
	def commit(hash)
		if hash.has_key?(:options)
			commit_message = "git commit #{hash[:options]} -m '#{hash[:message]}'"
		else
			commit_message = "git commit -m '#{hash[:message]}'"
		end
		@system_wrapper.execute(commit_message)
	end

	def push
		@system_wrapper.execute("git push origin master")
	end
end