class GitRepository
	def initialize(hash = {})
		@system_wrapper = hash[:system] if hash.has_key?(:system)
		@remote = hash[:remote] || 'origin'
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
		@system_wrapper.execute("git push #{@remote} #{branch}")
	end
end
