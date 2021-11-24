# Mod Why Test

## Discussion

From a module perspective:

The main module (*github.com/ejweber/mod-why-test*) has a single direct
dependency (*github.com/ejweber/mod-why-test/direct-mod*). This direct
dependency has two transitive dependencies 
(*github.com/ejweber/mod-why-test/transitive-used-mod* and
*github.com/ejweber/mod-why-test/transitive-unused-mod*).

    github.com/ejweber/mod-why-test 
    |-- github.com/ejweber/mod-why-test/direct 
        |-- github.com/ejweber/mod-why-test/transitive-used-mod 
        |-- github.com/ejweber/mod-why-test/transitive-unused-mod

From a package perspective:

The main package imports only one package 
(*github.com/ejweber/mod-why-test/direct-mod/direct-used-pkg*). That package 
imports only one package 
(*github.com/ejweber/mod-why-test/transitive-used-mod/transitive-used-pkg*).

    github.com/ejweber/mod-why-test/main
    |-- github.com/ejweber/mod-why-test/direct-mod/direct-used-pkg
        |-- github.com/ejweber/mod-why-test/transitive-used-mod/transitive-used-pkg

*github.com/ejweber/mod-why-test/transitive-unused-mod* DOES appear in the 
module dependency graph (because it is a direct dependency of the main module's 
direct dependency).

    --> go mod graph
    mod-why-test github.com/ejweber/mod-why-test/direct-mod@v0.0.0
    github.com/ejweber/mod-why-test/direct-mod@v0.0.0 github.com/ejweber/mod-why-test/transitive-unused-mod@v0.0.0
    github.com/ejweber/mod-why-test/direct-mod@v0.0.0 github.com/ejweber/mod-why-test/transitive-used-mod@v0.0.0

However, *github.com/ejweber/mod-why-test/transitive-unused-mod* is NOT actually 
a transitive dependency of the main module, because absolutely none of its code 
is involved in the build of the main modules packages.

"go mod why -m all" recognizes that 
*github.com/ejweber/mod-why-test/transitive-unused-mod* is NOT actually 
required, but that *github.com/ejweber/mod-why-test/transitive-used-mod* IS 
required:
    
    --> go mod why -m all
    # mod-why-test
    mod-why-test
    
    # github.com/ejweber/mod-why-test/direct-mod
    mod-why-test
    github.com/ejweber/mod-why-test/direct-mod/direct-used-pkg
    
    # github.com/ejweber/mod-why-test/transitive-unused-mod
    (main module does not need module github.com/ejweber/mod-why-test/transitive-unused-mod)
    
    # github.com/ejweber/mod-why-test/transitive-used-mod
    mod-why-test
    github.com/ejweber/mod-why-test/direct-mod/direct-used-pkg
    github.com/ejweber/mod-why-test/transitive-used-mod/transitive-used-pkg

"go mod why all" recognizes that none of the packages from 
*github.com/ejweber/mod-why-test/transitive-unused-mod* are required but that 
packages from *github.com/ejweber/mod-why-test/transitive-used-mod* ARE 
required:

    --> go mod why all
    # github.com/ejweber/mod-why-test/direct-mod/direct-used-pkg
    mod-why-test
    github.com/ejweber/mod-why-test/direct-mod/direct-used-pkg
    
    # github.com/ejweber/mod-why-test/transitive-used-mod/transitive-used-pkg
    mod-why-test
    github.com/ejweber/mod-why-test/direct-mod/direct-used-pkg
    github.com/ejweber/mod-why-test/transitive-used-mod/transitive-used-pkg
    
    # mod-why-test
    mod-why-test

## Conclusion

*github.com/ejweber/mod-why-test/transitive-unused-mod* should NOT be considered 
a transitive dependency of the main module. 
*github.com/ejweber/mod-why-test/transitive-used-mod* SHOULD be considered a 
transitive dependency of the main module. "go mod why -m all" is capable 
of correctly making this determination.
