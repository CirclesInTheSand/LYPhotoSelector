#!/usr/bin/python
#
# P4Merge Launch and Merge script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
import sys
import os

bundleIdentifier = 'com.perforce.p4merge'
helperPath = 'Contents/MacOS/p4merge'

appPath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(bundleIdentifier)

if appPath is None:
	error = 'Application with the bundle identifier "%s" does not exist'  % (bundleIdentifier)
	raise ValueError(error)

os.system('"%s" "%s" "%s" "%s" "%s"' % (os.path.join(appPath, helperPath), sys.argv[5], sys.argv[1], sys.argv[3], sys.argv[7]))