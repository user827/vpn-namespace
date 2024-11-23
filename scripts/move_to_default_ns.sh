#!/bin/sh
set -eu

# Because accessing pid would require sys_prace cap otherwise
ns=$1
dev=$2
ip -netns "$ns" link set dev "$dev" down netns "$$"
