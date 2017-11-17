#!/usr/bin/python
#
# Helper path script
# Copyright (c) Zennaware GmbH, 2012. All rights reserved.
#

from AppKit import NSWorkspace
from AppKit import NSFileManager
import sys
import os

def path(bundleIdentifiers, localPath):

  appPath = None
  
  for bundleIdentifier in bundleIdentifiers:
    appPath = NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier_(bundleIdentifier)

    if appPath is not None:
      break

  path = None

  if appPath is not None:
    path = os.path.join(appPath, localPath)
      
  return path
