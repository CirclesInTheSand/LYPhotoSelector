#!/usr/bin/python
#
# Kaleidoscope Launch and Merge script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
from AppKit import NSFileManager
from distutils.version import StrictVersion
from Foundation import NSBundle
import os
import sys

def supportsMergeAtPath(path):
  
  bundle = NSBundle.bundleWithPath_(path)
  version = bundle.objectForInfoDictionaryKey_("CFBundleShortVersionString")
  
  if StrictVersion(version) >= StrictVersion('2.0.0'):
    return True
  else:
    return False

appPath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_('com.blackpixel.kaleidoscope')

if appPath is None:
  raise ValueError('Unable to locate Kaleidoscope')

if supportsMergeAtPath(appPath):
  
  helperPath = '/usr/local/bin/ksdiff'
  
  if NSFileManager.defaultManager().fileExistsAtPath_(helperPath) == False:
    raise ValueError('Unable to locate the ksdiff command line tool')
  else:
    os.system('"%s" --merge --output "%s" --base "%s" "%s" "%s"' % (helperPath, sys.argv[7], sys.argv[5], sys.argv[1], sys.argv[3]))

else:
  raise ValueError('Merge not supported')