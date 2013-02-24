require 'git_repository'

task :test_commit, :message do |t, args|
	@git = GitRepository.new
	@git.pull
	Rake::Task[:run_tests].invoke
	commit(args.message)
end

task :run_tests do
	Dir.glob("test/*.rb") do |file|
		sh "ruby '#{file}'"
	end
end

def commit(message)
	if(@git.has_untracked?)
		@git.add
	end
	if(@git.has_changes?)
		@git.commit(:message => message, :options => "-a") 
	end
end
