require 'git_repository'

task :online, :message do |t, args|
	git = GitRepository.new
	git.pull
	Rake::Task[:run_tests].invoke
	commit(args.message,git)
	git.push
end

task :offline, :message do |t, args|
	git = GitRepository.new
	Rake::Task[:run_tests].invoke
	commit(args.message,git)
end

task :run_tests do
	Dir.glob("test/*.rb") do |file|
		sh "ruby '#{file}'"
	end
end

def commit(message,git_repository)
	if(git_repository.has_untracked?)
		git_repository.add
	end
	if(git_repository.has_changes?)
		git_repository.commit(:message => message, :options => "-a") 
	end
end
