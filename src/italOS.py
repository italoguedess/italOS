#!/usr/bin/env python
import os, platform, subprocess

username = subprocess.getoutput("whoami")
print("Hello fellow", username,"I hope you're doing ok!")

def check_if_os_is_arch():
  system_id = platform.freedesktop_os_release()["ID_LIKE"]
  if system_id != "arch":
    print("Hello! I noticed you're using", system_id,
          ", unfortunately this script only supports archlinux ;(")
    exit()
  else:
    print("I also use", system_id, "btw")


check_if_os_is_arch()
print("testing")
