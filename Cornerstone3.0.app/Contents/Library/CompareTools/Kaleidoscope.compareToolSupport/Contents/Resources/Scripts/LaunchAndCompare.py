#!/usr/bin/python
#
# Kaleidoscope Launch and Compare script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
from AppKit import NSFileManager
from distutils.version import StrictVersion
from Foundation import NSBundle
import os
import sys

def packageIncludesKSDiff(path):
  
  bundle = NSBundle.bundleWithPath_(path)
  version = bundle.objectForInfoDictionaryKey_("CFBundleShortVersionString")
  
  if StrictVersion(version) >= StrictVersion('2.0.0'):
    return False
  else:
    return True

path = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_('com.blackpixel.kaleidoscope')

if path is None:
 path = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_('com.madebysofa.kaleidoscope')

if packageIncludesKSDiff(path):
  path = os.path.join(path, 'Contents/MacOS/ksdiff')
else:
  path = '/usr/local/bin/ksdiff'

exists = NSFileManager.defaultManager().fileExistsAtPath_(path)

if exists == False:
  raise ValueError('Unable to locate the ksdiff command line tool at %s' % path)

os.system('"%s" "%s" "%s"' % (path, sys.argv[1], sys.argv[3]))