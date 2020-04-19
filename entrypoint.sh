#!/bin/bash

set -eux

eval "$(swiftenv init -)"

swift $*