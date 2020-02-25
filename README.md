[![Pypi version](https://img.shields.io/pypi/v/cscope-manager)](https://pypi.org/project/cscope-manager/)
[![Build Status](https://travis-ci.com/susu9/cscope-manager.svg?branch=master)](https://travis-ci.com/susu9/cscope-manager)
[![Python Compatibility](https://img.shields.io/pypi/pyversions/cscope-manager)](https://travis-ci.com/susu9/cscope-manager)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/susu9/cscope-manager.svg)
![GitHub](https://img.shields.io/github/license/susu9/cscope-manager.svg)
# cscope-manager
A tool helps you manage cscope/ctags tags

# Installation
```shell
pip install cscope-manager
```

# Custimization
You can create a config file in ~/.csmgr.config to customize your preference
```
# Supported configurations and format
project_list: .csmgr.project
suffixes = .cpp
out_list = map.files
meta_files = cscope.in.out cscope.out cscope.po.out tags
exclude_dirs = dir
# Note: Only supprot $out_list. Not support other variables interpolation
exec_cmds = cscope -bqk -i $out_list && ctags -L $out_list
display_max = 20
delim     = ........................................
delim_end = ****************************************
```

# Features
1. Manage source code by a project list (.csmgr.project)
2. Generate file list (i.e. cscope.files) by the project list.
3. Remove duplicate file pathes
4. Remove symbolic link
5. Remove not existed files
6. Run commands for tag generation

# Example
1. Add files to project list
```shell
csmgr a.c b.c
```
2. Add folders to project list
```shell
csmgr dir1/ dir2/
```
3. Update file list
```shell
# add current directory to project list
csmgr .
# files layout have been changed under ./
mv dir1 dir2
# update file list
csmgr -u
```
4. Edit project list
```shell
# Method I
csmgr [path]
# Method II
vim .csmgr.project
```

# Screenshot

![example](https://github.com/susu9/cscope-manager/blob/master/screenshot-1.png)

# Usage
```
Use config file: /Users/rickchang/.csmgr.config
usage: csmgr [-h] [-u] [-s SUFFIXES [SUFFIXES ...]] [-f] [-c CONFIG_FILE]
             [-o OUT_LIST] [-m META_FILES [META_FILES ...]]
             [-e EXCLUDE_DIRS [EXCLUDE_DIRS ...]] [-d] [--dry-run]
             [--max-display MAX_DISPLAY] [-x EXEC_CMDS [EXEC_CMDS ...]]
             [--verbose] [-v]
             [path [path ...]]

positional arguments:
  path                  add path to project list (.csmgr.project) and generate
                        tag if project list is changed ex. dir/, file.c

optional arguments:
  -h, --help            show this help message and exit
  -u, --update          update list file according to project list and
                        generate tag
  -s SUFFIXES [SUFFIXES ...], --suffixes SUFFIXES [SUFFIXES ...]
                        assign suffixes filter (default: .c .h .js .cpp .py
                        .scss)
  -f, --force           delete meta data and generate tag
  -c CONFIG_FILE, --config-file CONFIG_FILE
                        assign config file (default: ~/.csmgr.config)
  -o OUT_LIST, --out-list OUT_LIST
                        assign the name of output list file (default:
                        cscope.files)
  -m META_FILES [META_FILES ...], --meta-files META_FILES [META_FILES ...]
                        assign meta data files (default: cscope.in.out
                        cscope.out cscope.po.out tags)
  -e EXCLUDE_DIRS [EXCLUDE_DIRS ...], --exclude-dirs EXCLUDE_DIRS [EXCLUDE_DIRS ...]
                        assign exclude dirs (default: .git node_modules)
  -d, --delete-meta     delete all meta data
  --dry-run             show what would be done
  --max-display MAX_DISPLAY
                        assign how many paths will be shown in the log
  -x EXEC_CMDS [EXEC_CMDS ...], --exec-cmds EXEC_CMDS [EXEC_CMDS ...]
                        assign cmd to generate tag. $out_list will be replaced
                        by list file name. Cmds will be triggered only when a
                        new file is added in $out_list. (default: cscope -bqk
                        -i $out_list && ctags -L $out_list)
  --verbose             show more logs
  -v, --version         show program's version number and exit
```
