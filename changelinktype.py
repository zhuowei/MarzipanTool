#!/usr/bin/env python
from __future__ import print_function
import sys

try:
	xrange          # Python 2
except NameError:
	xrange = range  # Pyhton 3


def u32(a, i):
	return a[i] | (a[i+1] << 8) | (a[i+2] << 16) | (a[i+3] << 32)
def wu32(a, i, v):
	a[i] = v & 0xff
	a[i+1] = (v >> 8) & 0xff
	a[i+2] = (v >> 16) & 0xff
	a[i+3] = (v >> 24) & 0xff

with open(sys.argv[1], "r") as infile:
	indata = infile.read()
indata = bytearray(indata)

filestart = 0
if u32(indata, filestart) == 0xbebafeca:
	print("you need to lipo first!")
	exit(1)

mach_header_ncmds = u32(indata, filestart + 16)
#print("number of load commands:", mach_header_ncmds)

cmdstart = filestart + 32
LC_VERSION_MIN_MACOSX = 0x24
LC_VERSION_MIN_IPHONEOS = 0x25
LC_SOURCE_VERSION = 0x2A

for i in xrange(mach_header_ncmds):
	cmdtype = u32(indata, cmdstart)
	cmdsize = u32(indata, cmdstart + 4)
	#print("off", hex(cmdstart), "cmd", cmdtype, "size", cmdsize)
	if cmdtype == LC_VERSION_MIN_IPHONEOS:
		print("found iphone os")
		nextcmdtype = u32(indata, cmdstart + cmdsize)
		if nextcmdtype != LC_SOURCE_VERSION:
			print("oh no, we can't remove the next load command")
			exit(1)
		newfrontdata = indata[0:cmdstart]
		#print(u32(indata, cmdstart + cmdsize + 4))
		# build_version_command
		newmiddledata = "\x32\x00\x00\x00" + "\x20\x00\x00\x00" + "\x06\x00\x00\x00" + \
			"\x00\x00\x0c\x00" + "\x00\x00\x0c\x00" + "\x01\x00\x00\x00" + \
			"\x03\x00\x00\x00" + "\x01\x01\x98\x01"
		newenddata = indata[cmdstart + 32:]
		wu32(newfrontdata, 16, mach_header_ncmds - 1)
		newdata = newfrontdata + newmiddledata + newenddata
		if len(newdata) != len(indata):
			print("I screwed up:", len(newdata), len(indata))
		indata = newdata
		break
	cmdstart += cmdsize
with open(sys.argv[2], "w") as outfile:
	outfile.write(indata)
