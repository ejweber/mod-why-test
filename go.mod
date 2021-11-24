module mod-why-test

go 1.16

require github.com/ejweber/mod-why-test/direct-mod v0.0.0

replace (
	github.com/ejweber/mod-why-test/direct-mod => ./direct-mod
	github.com/ejweber/mod-why-test/transitive-unused-mod => ./transitive-unused-mod
	github.com/ejweber/mod-why-test/transitive-used-mod => ./transitive-used-mod
)
