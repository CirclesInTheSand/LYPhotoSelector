#!/usr/bin/python
#
# DeltaWalker Launch and Compare script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
import sys
import os

bundleIdentifier = 'com.deltopia.deltawalker'
helperPath = 'Contents/MacOS/DeltaWalker'

appPath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(bundleIdentifier)

if app_path is None:
	error = 'Application with the bundle identifier "%s" does not exist'  % (bundleIdentifier)
	raise ValueError(error)

os.system('"%s" "%s" "%s"' % (os.path.join(app_path, helper_path), sys.argv[1], sys.argv[3]))