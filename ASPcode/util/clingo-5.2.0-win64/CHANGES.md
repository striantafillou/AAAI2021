# Changes

## clingo 5.2
  * switch to MIT license
  * improve compatibility with abstract gringo
  * switch build system from scons to cmake
  * improve windows compatibility
  * make tests and examples python 3 compatible
  * bison and re2c are no longer required to build source releases
  * update to clasp 3.3.0
  * the CLINGOPATH environment variable can be set
    to control from where to include files in logic programs
  * propagators can add variables while solving now
  * refactor interfaces (breaking backward compatibility)
    * there is just one solve function now
    * in the C API do not pass structs by value to functions
      because FFIs of some languages do not support this
  * fix cleanup function
  * numerous other bugfixes not listed here
## clingo 5.1.1
  * fix thread id to start with one in propagator.undo in lua
  * fix version macro in clingo.h
  * fix added missing methods to get thread id to model in lua/python
  * fix child\_key property in python ast
## clingo 5.1.0
  * update to clasp 3.2.1
  * add interface to add variables during propagation
  * add interface to inspect ground rules (C/C++ only)
  * add experimental interface to access clasp facade (C/C++ only)
  * fixed smodels output (--output=smodels)
## clingo 5.0.0
  * cleanup of python and lua API (breaks backwards compatibility)
  * added new aspif output format replacing the old smodels format
  * added input language support for clasp features
    * #edge directives to add acyclicity constraints
    * #project directives for enumeration of projected models
    * #heuristic directives to steer clasp's search
  * added theory atoms to write aggregate like constructs
  * added stable C API documented with doxygen
  * added experimental C++ API based on C API
  * added theory propagator interface to clingo APIs
  * added support for compilation with Visual Studio 2015
  * improved data structures to reduce memory consumption on typical input
  * updated to clasp version 3.2.0 + patches
## gringo/clingo 4.5.4
  * fixed bug when creating multiple Control objects
    (affects lua only)
  * fixed bug when trying to configure more solvers than in portfolio
    (affects python only)
  * fixed #disjoint constraints
  * improved build scripts
  * added option to keep facts in normal rules
## gringo/clingo 4.5.3
  * fixed regression w.r.t gringo 4.4 in translation of conditional literals
  * fixed projection in incremental programs
  * fixed bug with (double) negative literals in minimize constraints
## gringo/clingo 4.5.2
  * fixed memory leak in python API when enumerating models
  * updated to clasp version 3.1.3
## gringo/clingo 4.5.1
  * ground term parser returns None/nil for undefined terms now
  * added warning if a global variable occurs in a tuple of an aggregate element
  * added auto detection of libraries
  * changed option --update-domains into API function Control:cleanup\_domains
  * fixed domain cleanup when used with minimize constraints
  * fixed grounding of recursive disjunctions (regression in 4.5.0)
  * fixed Control.stats in lua bindings
  * fixed a bug in clingo that would print 0-ary classically negated atoms wrongly
## gringo/clingo 4.5.0
  * fixed grounding of recursive aggregates
  * fixed usage of lua\_next
  * fixed bug when applying constant definitions
  * updated underlying clasp to version 3.1.1
  * added support for negation in front of relation literals
  * added option --update-domains to cleanup gringo's domains
    using clasp's top-level assignment when solving incrementally
  * added domain inspection to scripting interface
  * added term parser to scripting interface
  * added support for python 3 (experimental)
  * added support for one elementary tuples
  * added support for unary - operator in front of functions and symbols
  * added support for recursive nonmonotone aggregate via translation
  * added program reify to reify logic programs
  * added option to rewrite minimize constaints for use with reify
  * changed inbuilt iclingo mode
    (breaks backwards compatibility)
  * changed handling of pools, intervals, and undefined operations according to AG
    (breaks backwards compatibility)
  * changed handling of ==, it is treated like = now
  * changed SolveFuture.interrupt to SolveFuture.cancel
    (breaks backwards compatibility)
## gringo/clingo 4.4.0
  * updated underlying clasp to version 3.1.0
    * this version brings numerous fixes regarding incremental solving
  * scripting API changes
    * ground takes a list of programs to ground now and immediately starts
      grounding (breaks backwards compatibility)
    * asolve has been renamed to solveAsync
      (breaks backwards compatibility)
    * the solver configuration is better integrated now
      (breaks backwards compatibility)
    * solver statistics are a property now
      (breaks backwards compatibility)
    * added a method to add clauses during solving
    * added load method to load files
    * added solveIter method to iterate over methods without using a callback
    * added optional assumptions to solve/solveAsync/solveIter method
    * enableEnumAssumption became a property
  * added library that can be imported in python
  * rules with fact heads where not simplified in all cases
  * fixed grounding of recursive aggregates
  * fixed translation of aggregates with multiple guards
## gringo/clingo 4.3.0
  * fixed bug with incremental parameters in minimize constraints
  * fixed handling of empty tuples
  * fixed translation of conditional literals
  * fixed translation of factual body aggregates
  * fixed bug not properly recognizing aggregates as non-monotone
  * fixed bug not properly grounding recursive head aggregates
  * fixed bug with recursive negated aggregates
  * fixed bug with head aggregates with multiple elements
  * improved handling of conditional literals
  * added method to get optimization values of model in scripting language
  * clingo uses clasp 3.0 now
## gringo/clingo 4.2.1
  * fixed bug in simplification of aggregates
  * fixed bug with raw strings in macros
  * fixed compilation issues with older glibc versions
  * fixed output for enumeration of cautious consequences
  * fixed bugs in clasp library
    * fixed race in parallel model enumeration
    * fixed incremental optimization
    * fixed cleanup up of learnt constraints during incremental solving
  * workaround for libstdc++'s bad choice for hash<uint64_t> on 32bit arches
## gringo/clingo 4.2
  * added clingo 
    * supports very flexible scripting support
    * can cover iclingo and oclingo functionality now
  * added stack traces to lua error messages
  * added support for incremental optimization
  * improved python error messages
  * renamed gringo.Function to gringo.Fun
  * removed luabind dependency
  * removed boost-python dependency
  * consistently use not instead of #not as keyword for negation
  * fixed translation of conditions in head aggregates
  * fixed replacement of constants
  * fixed grounding of recursive head aggregates
  * fixed translation of head aggregates
  * fixed show statements for CSP variables (condition was ignored)
  * fixed plain text output of body aggregates
  * added a ton of new bugs
## gringo 4.1
  * added scripting languages python and lua
  * added -c option to define constants
  * added constraints over integer variables
    * linear constraints
    * disjoint constraints
    * show statements for constraint variables
    * (experimental and subject to change)
  * improved translation of disjunctions
  * fixed include directives
  * fixed preprocessing of definitions
  * fixed lparse translation of optimization constructs

