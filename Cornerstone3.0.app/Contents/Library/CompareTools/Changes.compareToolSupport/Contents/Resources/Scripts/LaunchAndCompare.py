#!/usr/bin/python
#
# Changes Launch and Compare script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
import sys
import os
import HelperPath

path = HelperPath.path(['com.bitbq.Changes','com.skorpiostech.Changes'], 'Contents/Resources/chdiff')

if path is None:
  raise ValueError('Unable to find the chdiff command line tool')

os.system('"%s" "%s" "%s"' % (path, sys.argv[1], sys.argv[3]))