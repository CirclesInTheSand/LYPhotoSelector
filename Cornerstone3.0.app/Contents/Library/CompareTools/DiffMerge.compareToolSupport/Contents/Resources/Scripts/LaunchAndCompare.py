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

os.system('"%s" -nosplash "%s" "%s"' % (os.path.join(appPath, helperPath), sys.argv[1], sys.argv[3]))