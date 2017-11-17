#!/usr/bin/python
#
# TextMate Launch and Compare script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
import sys
import os

v1BundleIdentifier = 'com.macromates.textmate'
v2BundleIdentifier = 'com.macromates.TextMate'
v2PreviewBundleIdentifier = 'com.macromates.TextMate.preview'

helperPath = 'Contents/Resources/mate'

appPath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(v2BundleIdentifier)

if appPath is None:
	appPath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(v2PreviewBundleIdentifier)
	
	if appPath is None:
		appPath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(v1BundleIdentifier)
		
		if appPath is None:
			raise ValueError('Application not found')

os.system('/usr/bin/diff "%s" "%s" | "%s" --async' % (sys.argv[1], sys.argv[3], os.path.join(appPath, helperPath)))