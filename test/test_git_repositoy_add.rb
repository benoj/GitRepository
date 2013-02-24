require 'test/unit'
require 'git_repository'

class GitRepositoryAdd < Test::Unit::TestCase
	def test_that_when_repository_add_called_with_no_parameters_git_adds_all
		mock_system = MockSystemWrapper.new
		git = GitRepository.new(:system => mock_system)
		git.add
		assert_equal("git add .",mock_system.executed_command)
	end
end

class MockSystemWrapper
  attr_reader :executed_command

  def execute(command)
    @executed_command = command
  end
end

