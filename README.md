#GitRepository


##Introduction

This project was created to simplify the process of deploying applications using git. The project came about due to the authors own issues deploying an application using rake and git. 

##Installation

The package is installed on rubygems and can be installed using the following command line or adding the following line to your gemfile.

    gem install 'git_repository'

You will need to insert the following command in your project `require 'git_repository`
##Usage

###Creation

The initialization of GitReposity takes a hash of symbols, with the following options:

####options
* **:remote** - This represents the name of your git remote (defaults to origin if not specified)
* **:ssh_repository** - This representst the ssh URI of your git repository. You will need to add your public key to the repository provider (e.g. github). This is an optional parameter.
* **:branch** - This represents the branch that you are pushing to or pulling from (defaults to master if not specified)
* **:system** - This is a wrapper around the system. This should not be specified unless you wish to use another system for calling git.

The following will create a repositiory pointing to origin on master 

    git = GitRepository.new

The following will create a repository pointing to origin on my_branch

    git = GitRepository.new(:branch => 'my_branch'

The following will create a repository pointing to git@your-repository.com on origin

    git = GitRepository.new(:ssh_repository => 'git@your-repository.com')

###Commiting

The git repository can be commited to by calling the .commit method. This method takes a hash of symbols, with the following options:

####options
* **:message** - This represents the message for the commit to your repository
* **:options** - This represents any options for git 


The following will commit to git with a message

    git = GitRepository.new
    git.commit(:message => 'first commit')

The following will commit a specific file to git with a message

    git = GitRepository.new
    git.commit(:message => 'updated rakefile', :options => '-F rakefile.rb')


###Pushing

The git repository can be pushed to by calling the .push method. This method takes a hash of symbols, with the following options:

####options
* **:options** - This represents any options for git 


The following will commit to git with a message, and push the contents to the repository

    git = GitRepository.new
    git.commit(:message => 'first commit')
    git.push

The following will commit a specific file to git with a message and forcefully pushes to the repositor

    git = GitRepository.new
    git.commit(:message => 'updated rakefile')
    git.push(:options => "-f")

###Pulling

The git repository can be pulled from by calling the .pull method. This method takes a hash of symbols, with the following options:

####options
* **:options** - This represents any options for git 


The following will pull changes to a repository, before commiting and pushing

    git = GitRepository.new
    git.pull
    git.commit(:message => 'first commit')
    git.push

The following will pull changes to a repository, before commiting and pushing to the repository with a rebase option

    git = GitRepository.new
    git.pull
    git.commit(:message => 'first commit', :options => '--rebase')
    git.push

###Adding

Unversioned files can be added to the repository by calling the .add method. This method takes a hash of symbols, with the following options:

####options
* **:files** - This represents any file/regular expression for files to be added (defaults to all files if not set)
* **:options** - This represents any options for git 


The following will add all unversioned files to the repository, before commiting and pushing
    git = GitRepository.new
    git.add
    git.commit(:message => 'first commit')
    git.push

The following will add all unversioned files in the src directory to the repository, before commiting and pushing
    git = GitRepository.new
    git.add(:files => '/src/*')
    git.commit(:message => 'first commit')
    git.push


###Getting information about your git repository

In some situations, you may wish to find out if there have been updates to files in your project, or if there are unversioned files. This information can be obtained by calling `.has_changes?` or `.has_untracked?`


The following will determine if there are any changes to your git repository (e.g. files modified) and then push to your repository.
    git = GitRepository.new
    if(git.has_changes?)
    	git.commit(:message => 'updated project')
    	git.push
    end
    
The following will determine if there have been and new files/folders added to your repository and then add all files to the repository and commit.
    git = GitRepository.new
    if(git.has_untracked?)
    	git.add
    	git.commit(:message => 'added files to project')
    	git.push
    end

##Author
###Ben Flowers

* Twitter: @BDWFlowers
* LinkedIn: [Ben Flowers](http://www.linkedin.com/pub/ben-flowers/41/414/3a4)
* Email: ben.j.flowers@gmail.com

##Example

The following is an extract from the rakescript, used by this project:

    task :online, :message do |t, args|
		git = GitRepository.new
		git.pull
		Rake::Task[:run_tests].invoke
		commit(args.message,git)
		git.push
    end

    def commit(message,git_repository)
		if(git_repository.has_untracked?)
			git_repository.add
		end
		if(git_repository.has_changes?)
			git_repository.commit(:message => message, :options => "-a") 
		end
	end

This raketask takes a commit message, pulls changes from the repository, runs the unit tests, checks for untracked files (adding them if necessary) then checks for changes to the repository an commits all files with the message passed in from the rake command.

This task is called as follows:

    rake online['hello world!']