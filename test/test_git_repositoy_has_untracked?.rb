require 'test/unit'
require_relative '../lib/git_repository'

class GitRepositoryHasUntracked < Test::Unit::TestCase
	def test_that_return_true_when_untracked_files_exist
		mock_system = MockSystemWrapper.new(true)
		git = GitRepository.new(:system => mock_system)
		has_untracked = git.has_untracked?
		assert_equal(true,has_untracked)
	end

	def test_that_return_false_when_no_untracked_files_exist
		mock_system = MockSystemWrapper.new(false)
		git = GitRepository.new(:system => mock_system)
		has_untracked = git.has_untracked?
		assert_equal(false,has_untracked)
	end
end

class MockSystemWrapper
	def initialize(has_untracked)
		if(has_untracked)
			@return_message = "# On branch master \n# Untracked files:"
		else
			@return_message = "up to date"
		end
	end
	def execute(command)
		return @return_message
	end
end

