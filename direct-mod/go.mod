module github.com/ejweber/mod-why-test/direct-mod

go 1.16

require (
	github.com/ejweber/mod-why-test/transitive-unused-mod v0.0.0
	github.com/ejweber/mod-why-test/transitive-used-mod v0.0.0
)

replace (
	github.com/ejweber/mod-why-test/transitive-unused-mod => ../transitive-unused-mod
	github.com/ejweber/mod-why-test/transitive-used-mod => ../transitive-used-mod
)
