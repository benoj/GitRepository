require 'test/unit'
require_relative '../git_repository'
class GitRepositoryCommit < Test::Unit::TestCase
  def test_system_called_with_correct_git_message
    mock_system = MockSystemWrapper.new
    git = GitRepository.new(mock_system)
    commit_message = "this is a test message"
    git.commit(commit_message)
    assert_equal("git commit -m '#{commit_message}'",mock_system.executed_command )
  end
end

class MockSystemWrapper
  attr_reader :executed_command

  def execute(command)
    @executed_command = command
  end
end
