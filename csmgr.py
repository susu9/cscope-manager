#!/usr/bin/env python2
#
# Copyright (C) Rick Chang <chchang915@gmail.com>
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
import sys
import os
import subprocess
import shutil

RED   = "\x1b[31m"
GREEN = "\x1b[32m"
NONE  = "\x1b[0m"
MAX_SHOW = 20

csdb="cscope.files"
csdb_backup="." + csdb
csdb_tmp=".t" + csdb

cscope_args=("cscope", "-bqk")
ctags_args=("ctags", "-a", "-L", csdb)
ctags_plat_args = {
	"linux": ctags_args,
	"linux2": ctags_args,
	"darwin": ("/usr/local/bin/ctags", "-a", "-L", csdb)
}

diff_args=("diff", "-u", csdb, csdb_backup)

tag_db = ("cscope.in.out", "cscope.out", "cscope.po.out", "tags")
suffix_list = ('.c', '.h', '.js')

def loge(s):
	print(RED + s + NONE)

def logm(s):
	print(GREEN + s + NONE)

def filterdir(folder):
	flist = []
	for path, dirs, files in os.walk(folder):
		for f in files:
			flist += filterfile(os.path.join(path, f))
	return flist

def filterfile(path):
	return [path] if path.endswith(suffix_list) and not os.path.islink(path) else []

def deletemeta():
	for f in tag_db:
		try:
			os.remove(f)
		except:
			pass

def updatetag(regen=False):
	if regen:
		deletemeta()
	subprocess.call(cscope_args)
	subprocess.call(ctags_plat_args[sys.platform])
	logm("Updating tag done.")

def get_taglist(path):
	if os.path.isfile(path):
		return filterfile(path);
	elif os.path.isdir(path):
		return filterdir(path);
	else:
		loge("'" + path + "' not exited.")
		return []

def backup_taglist():
	shutil.copy2(csdb, csdb_backup)

def showdiff_taglist():
	subprocess.call(diff_args)

def recover_taglist():
	if not (os.path.isfile(csdb) or os.path.isfile(csdb_backup)):
		return
	os.rename(csdb, csdb_tmp)
	os.rename(csdb_backup, csdb)
	os.rename(csdb_tmp, csdb_backup)
	logm("Recoving taglist Done.")

def save_taglist(l):
	n = len(l)
	if n == 0:
		return 0

	if os.path.isfile(csdb):
		backup_taglist()

	with open(csdb, 'a') as f:
		for i, t in enumerate(l):
			if i < MAX_SHOW:
				print(t)
			f.write(t + "\n")

	if MAX_SHOW and n > MAX_SHOW:
		print('...')
	return n

def add_taglist(l):
	addlist = []
	db = set(opendb())
	
	for t in l:
		if not t in db:
			addlist.append(t)
	return save_taglist(addlist)

def opendb():
	if not os.path.isfile(csdb):
		return []
	with open(csdb, 'r') as f:
		return f.read().splitlines()

def usage(name, detail=False):
	print("Usage: " + name + " [-f | -d | -h] <dir | file>...")
	if detail:
		print("  -f: forcely regenerate tags from cscope.files")
		print("  -r: recover tags to the last change")
		print("  -d: delete all meta data except for cscope.files")
		print("  -h: detailed information for arguments")

def main(argv):
	taglist = []

	if len(argv) == 1:
		usage(argv[0])
		sys.exit(1)

	if argv[1] == '-d':
		return deletemeta()
	elif argv[1] == '-f':
		return updatetag(True)
	elif argv[1] == '-r':
		recover_taglist()
		return updatetag(True)
	elif argv[1] == '-h':
		return usage(argv[0], True)

	for path in argv[1:]:
		taglist += get_taglist(path)
	
	n = add_taglist(taglist)
	logm('Add ' + str(n) + ' file(s)')

	if n:
		updatetag()

if __name__ == '__main__':
	main(sys.argv)
