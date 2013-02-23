require 'test/unit'
require '../git_repository'

class GitRepositoryCommit < Test::Unit::TestCase
  def test_system_called_with_correct_git_message_for_deafult_remote
    mock_system = MockSystemWrapper.new
    git = GitRepository.new(:system => mock_system)
    git.push
    assert_equal("git push origin master", mock_system.executed_command)
  end

  def test_system_called_with_correct_git_message_for_branch
    mock_system = MockSystemWrapper.new
    git = GitRepository.new(:remote => "git_repository", :system => mock_system)
    git.push
    assert_equal("git push git_repository master", mock_system.executed_command)
  end
end

class MockSystemWrapper
  attr_reader :executed_command

  def execute(command)
    @executed_command = command
  end
end
