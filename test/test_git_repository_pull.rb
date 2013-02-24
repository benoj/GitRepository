require 'test/unit'
require 'lib/git_repository'

class GitRepositoryPull < Test::Unit::TestCase
  def test_system_called_with_correct_git_message
    mock_system = MockSystemWrapper.new
    git = GitRepository.new(:system => mock_system)
    git.pull
    assert_equal("git pull origin master",mock_system.executed_command )
  end

  def test_system_called_with_correct_git_message_and_options
 mock_system = MockSystemWrapper.new
    git = GitRepository.new(:system => mock_system)
    git.pull(:options => "-v")
    assert_equal("git pull -v origin master",mock_system.executed_command )
  end

end

class MockSystemWrapper
  attr_reader :executed_command

  def execute(command)
    @executed_command = command
  end
end
