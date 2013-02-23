require 'git_repository'

task :test_commit, :message do |t, args|
	Rake::Task[:run_tests].invoke
	commit(args.message)
end

task :run_tests do
	Dir.glob("test/*.rb") do |file|
		sh "ruby '#{file}'"
	end
end

def commit(message)
	git = GitRepository.new
	git.commit(:message => message, :options => "-a") if git.has_changes? else puts "No Changes"
end
