Install Guide
=============

## Requirements

 1. **console version** of [git](http://git-scm.com/), you can use the 
 [github install guide](https://help.github.com/articles/set-up-git); 
 reference: [git docs](http://git-scm.com/documentation), or 
 [git ref](http://gitref.org/)

 2. **if you own private repositories**: SSH access to the repos 
 ([SSH guide for github](https://help.github.com/articles/generating-ssh-keys))

 3. a working server; the web server is the only required component, the server
 running dart, etc is not required
 
 4. **npm** (node's package manager)
 
 5. **pub** (dart's package manager) and **dart2js** (dart's javascript 
 compiler)

## Steps

To get everything up and running requires a 3 step process.
 
 1. setting up the public files
 2. installing dependencies
 3. verifying permissions

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

### Step 2: Installing dependencies

The project relies on two sperate dependency managers, `bower` for javascript 
and css dependencies (namely, TodoMVC template dependencies), and `pub` for 
dart library dependencies. You will also need dart2js to compile the 
application to javascript.

To get `bower` you will first need `npm` which you can obtain by installing 
`node`, see http://nodejs.org/ for detailed instructions. Once you have 
obtained the `npm` package manager assuming it is in your `PATH` run
`npm install bower -g` to install bower.

In your project root you can then run,

	bower install
	
This will read the local `component.json` file and install `todomvc-common`.

For `pub` see http://www.dartlang.org/ for the latest installation 
instructions. At this time any installation are still subject to change so you
will have to read the documentation for the current process for installing it
and using it.

The `pubspec.yaml` you will need to run `pub` against is located in the `app/`
folder.

Please follow the same process for compiling dart to javascript. The compaile 
should be available in the same distribution with `pub`. You will need to run 
the compiler against `app/loader.dart`.

If you are running in a gui environment you can simply install the DartEditor
and you will be able to perform `pub install` and compile to javascript 
interactively from the Tools menu.   

### Step 3: Verifying permissions

You can check the current permissions via `ls -l`. Your files should be readable
by the user under which the server is running. Your directories should also be
executable and readable. Be careful not to run the dependency managers from the
previous step as root or new files may have malformed permissions.

If the user or user group is wrong you can change it by doing

	cd /path/to/www
	cd PROJECT
	sudo chown -R USER:GROUP .
