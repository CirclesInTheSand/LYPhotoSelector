#!/usr/bin/python
#
# FileMerge Launch and Merge script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#


import os
import sys
import FileMergeHelper

helperPath = FileMergeHelper.helperPath()

if helperPath == None:
  raise ValueError('Unable to find FileMerge helper')

os.system('"%s" "%s" "%s" -ancestor "%s" -merge %s' % (helperPath, sys.argv[1], sys.argv[3], sys.argv[5], sys.argv[7]))