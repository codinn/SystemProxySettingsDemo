#! /bin/sh

# <codex>
# <abstract>Script to remove everything installed by the sample.</abstract>
# </codex>

# This uninstalls everything installed by the sample.  It's useful when testing to ensure that 
# you start from scratch.

sudo security -q authorizationdb remove "com.codinn.com.codinn.systemproxysettingsdemo.rights"

