Install Guide
=============

## Requirements

 1. **console version** of [git](http://git-scm.com/), you can use the 
 [github install guide](https://help.github.com/articles/set-up-git); 
 reference: [git docs](http://git-scm.com/documentation), or 
 [git ref](http://gitref.org/)

 2. **if you own private repositories**: SSH access to the repos 
 ([SSH guide for github](https://help.github.com/articles/generating-ssh-keys))

 3. a working server (LAMP/WAMP/MAMP are fine for development); the web server
 is the only required component, running dart, etc is not required

## Steps

To get everything up and running requires a 3 step process.
 
 1. setting up the public files
 2. verifying permissions

From here on we will consider your https or git protocol repository url as 
`REPO` and your project code name as `PROJECT`. These are placeholders, please
replace them in the example code bellow with your actual repo url and project 
code name.

Any other ALLCAPTICALS words bellow are also placeholders and you should not 
take them literally.

### Step 1: Setting up the public files

First we need to retrieve a local copy of the project files... (ie. `git clone`)

	cd /path/to/www
	git clone REPO PROJECT

### Step 2: Verifying permissions

You can check the current permissions via `ls -l`. Your files should be readable
by the user under which the server is running. Your directories should also be
executable and readable.

If the user or user group is wrong you can change it by doing

	cd /path/to/www
	cd PROJECT
	chown -R USER:GROUP .
