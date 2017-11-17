#!/usr/bin/python
#
# DeltaWalker Launch and Merge script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
import sys
import os

bundleIdentifier = 'com.deltopia.deltawalker'
helper_path = 'Contents/MacOS/DeltaWalker'

app_path = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(bundle_identifier)

if app_path is None:
	error = 'Application with the bundle identifier "%s" does not exist'  % (bundle_identifier)
	raise ValueError(error)

os.system('"%s" "%s" "%s" "%s" -merged="%s"' % (os.path.join(app_path, helper_path), sys.argv[1], sys.argv[3], sys.argv[5], sys.argv[7]))