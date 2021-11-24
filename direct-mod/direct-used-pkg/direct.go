package direct_used_pkg

import (
	"github.com/ejweber/mod-why-test/transitive-used-mod/transitive-used-pkg"
)

func DirectUsed() {
	transitive_used_pkg.TransitiveUsed()
}
