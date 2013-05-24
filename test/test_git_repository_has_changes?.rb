require 'test/unit'
require_relative '../lib/git_repository'

class GitRepositoryHasChanges < Test::Unit::TestCase
  def test_has_changed_returns_true_when_changes_have_occured
    mock_system = MockSystemWrapper.new(true)
    git = GitRepository.new(:system =>  mock_system)
    has_changes = git.has_changes?
    assert_equal(true,has_changes)
  end

  def test_has_changed_returns_false_when_no_changes_have_occured
    mock_system = MockSystemWrapper.new(false)
    git = GitRepository.new(:system =>  mock_system)
    has_changes = git.has_changes?
    assert_equal(true,has_changes)
  end
end

class MockSystemWrapper
  attr_reader :git_status
  def initialize(has_changes)
    @has_changes = has_changes
  end

  def execute(command)
    if(@has_changes)
      @git_status =   "# On branch master Changes to be committed:\n# Changes not staged for commit:\n# modified:   test/test_git_repository_has_changes?.rb"  
    else
      @git_status = "up to date"
    end
  end
end
