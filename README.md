For installation instructions read [INSTALL.md](INSTALL.md).

Octopi â€¢ [TodoMVC](http://todomvc.com)
======================================

A TodoMVC sample built with Octopi, a dart frontend library.

Octopi targets user friendly frontend scripting. There are no dependencies to
dart on the server and Octopi is no different then CSS in it's purpose, but as 
much as possible you shouldn't rely on it to do what you can do with css.

-

The dart code compiles to javascript and will run on all modern browsers.

-

## Short Octopi Conventions
 
 1. code should be modular, both in the way it's organized and in the way 
    it's written; avoid mashing different interests toghter such as 
    translation, rendering, state logic, etc. Indenpendent systems are easier 
    to manage and understand (abstracting logic and sharing methods is 
    encouraged). You are free to subscribe to  whichever model you wish, MVC, 
    Naked Objects, MVVC, etc.
    
 2. reusable code is favored over "facy code," any new approuches should be 
    weighted on their maintanability and not technical proess
    
 3. multiple overlapping indenpendent implementations that solve the same 
    problem are considered maintainable when each implementations focuses on a 
    different set of common use cases and their use either simplifies local 
    abstraction of code using them or their implementation is simplified by the
    focus on the specific problem
    
 4. only "source code" should be maintained under source control; ie. 
    no dependencies or compiled files
    
 5. html5 tags (section, header, etc) should not be used
 
 6. IDs should be avoided, outside of contexts where they can identify a 
    non-decorative html element (ie. #post_1234)
    
 7. All previous conventions are waved in favor of any tangible imediate 
    maintenance benefit.
    
 8. Doc comments are to be ignored outside of merely using them to write a 
    shorter sentence
    
 9. A comment should be placed in all ambigous contexts such as empty blocks,
 	else clauses, ending bracket for classes and functions in the global scope,
 	and any other similar context (the "..." comment is understood as "too 
 	simple and obvious from profiximity information to waste words and space 
 	explaining" and is placed to show that a comment was considered and 
 	intentionally ommited) — constructors and fields generally do not need 
 	comments so the "..." is not present on them.