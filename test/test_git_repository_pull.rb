require 'test/unit'
require 'git_repository'

class GitRepositoryPull < Test::Unit::TestCase
  def test_system_called_with_correct_git_message
    mock_system = MockSystemWrapper.new
    git = GitRepository.new(:system => mock_system)
    git.pull
    assert_equal("git pull",mock_system.executed_command )
  end

  # def test_system_called_with_correct_git_message_and_options
  #   mock_system = MockSystemWrapper.new
  #   git = GitRepository.new(:system => mock_system)
  #   commit_message = "this is a test message"
  #   commit_options = "-v"
  #   git.commit(:message => commit_message, :options => commit_options)
  #   assert_equal("git commit #{commit_options} -m '#{commit_message}'",mock_system.executed_command )
  # end

end

class MockSystemWrapper
  attr_reader :executed_command

  def execute(command)
    @executed_command = command
  end
end
