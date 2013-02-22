class GitRepository
	def initialize(system_wrapper)
		@system_wrapper = system_wrapper
	end
	def commit(message)
		@system_wrapper.execute("git commit -m '#{message}'")
	end
end