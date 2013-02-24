#GitRepository


##Introduction

This project was created to simplify the process of deploying applications using git. The project came about due to the authors own issues deploying an application using rake and git. 

##Installation

The package is installed on rubygems and can be installed using the following command line or adding the following line to your gemfile.

    gem install 'git_repository'

You will need to insert the following command in your project `require 'git_repository`
##Usage
###Creation

####options
* :remote - This represents the name of your git remote (defaults to origin if not specified)
* :ssh_repository - This representst the ssh URI of your git repository. You will need to add your public key to the repository provider (e.g. github). This is an optional parameter.
* :branch - This represents the branch that you are pushing to or pulling from (defaults to master if not specified)
* :system - This is a wrapper around the system. This should not be specified unless you wish to use another system for calling git.

The following will create a repositiory pointing to origin on master 
    git = GitRepository.new

The following will create a repository pointing to origin on my_branch
    git = GitRepository.new(:branch => 'my_branch'

The following will create a repository pointing to git@your-repository.com on origin
    git = GitRepository.new(:ssh_repository => 'git@your-repository.com')


