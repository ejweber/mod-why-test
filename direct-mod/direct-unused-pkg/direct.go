package direct_unused_pkg

import (
	"github.com/ejweber/mod-why-test/transitive-unused-mod/transitive-unused-pkg"
)

func DirectUnused() {
	transitive_unused_pkg.TransitiveUnused()
}
