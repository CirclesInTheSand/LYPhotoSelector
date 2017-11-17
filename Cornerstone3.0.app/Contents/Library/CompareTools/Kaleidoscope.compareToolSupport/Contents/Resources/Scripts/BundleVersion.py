#!/usr/bin/python
#
# Helper path script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
from Foundation import NSBundle
import sys

bundlePath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(sys.argv[1])
bundle = NSBundle.bundleWithPath_(bundlePath)

if bundle is not None:
	sys.stdout.write(bundle.objectForInfoDictionaryKey_("CFBundleShortVersionString"))