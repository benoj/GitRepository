require 'test/unit'
require 'git_repository'

class GitRepositoryAdd < Test::Unit::TestCase
	def test_that_when_repository_add_called_with_no_parameters_git_adds_all
		mock_system = MockSystemWrapper.new
		git = GitRepository.new(:system => mock_system)
		git.add
		assert_equal("git add .",mock_system.executed_command)
	end

	def test_that_when_repositoy_add_called_with_file_git_called_correctly
		mock_system = MockSystemWrapper.new
		git = GitRepository.new(:system => mock_system)
		git.add(:files => "*.rb")
		assert_equal("git add *.rb", mock_system.executed_command)
	end

	def test_system_called_with_correct_git_message_and_options
	    mock_system = MockSystemWrapper.new
	    git = GitRepository.new(:system => mock_system)
	    add_options = "-f"
	    git.add(:options => add_options)
	    assert_equal("git add #{add_options} .",mock_system.executed_command )
  end
end

class MockSystemWrapper
  attr_reader :executed_command

  def execute(command)
    @executed_command = command
  end
end

