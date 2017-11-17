#!/usr/bin/python
#
# FileMerge Helper script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
from AppKit import NSFileManager
import sys
import os

def helperPath():
  fileMergeIdentifier = 'com.apple.FileMerge'
  xcodeIdentifier = 'com.apple.dt.Xcode'
    
  fileMergeXcodeHelperPath = 'Contents/Developer/usr/bin/opendiff'
  fileMergeSystemHelperPath = '/usr/bin/opendiff'
  fileMergeDevHelperPath = '/Developer/usr/bin/opendiff'
  
  xcodePath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(xcodeIdentifier)
  fileMergePath = os.path.join(xcodePath, fileMergeXcodeHelperPath)
  
  helperPath = None
  
  if NSFileManager.defaultManager().fileExistsAtPath_(fileMergePath) == True:
    helperPath = fileMergePath
  elif NSFileManager.defaultManager().fileExistsAtPath_(fileMergeSystemHelperPath) == True:
    helperPath = fileMergeSystemHelperPath
  elif NSFileManager.defaultManager().fileExistsAtPath_(fileMergeDevHelperPath) == True:
    helperPath = fileMergeDevHelperPath

  return helperPath