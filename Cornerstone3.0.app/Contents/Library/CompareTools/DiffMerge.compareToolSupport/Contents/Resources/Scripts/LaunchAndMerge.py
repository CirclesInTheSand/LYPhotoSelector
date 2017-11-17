#!/usr/bin/python
#
# DiffMerge Launch and Compare script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
import sys
import os

bundleIdentifier = 'com.sourcegear.DiffMerge'
helperPath = 'Contents/MacOS/DiffMerge'

appPath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(bundleIdentifier)

if appPath is None:
	error = 'Application with the bundle identifier "%s" does not exist'  % (bundleIdentifier)
	raise ValueError(error)

os.system('"%s" -nosplash -result="%s" -t1="%s" -t2="%s" -t3="%s" -merge "%s" "%s" "%s"' % (os.path.join(appPath, helperPath), sys.argv[7], sys.argv[2], sys.argv[6], sys.argv[4], sys.argv[1], sys.argv[3], sys.argv[5]))