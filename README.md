[![Pypi version](https://img.shields.io/pypi/v/cscope-manager)](https://pypi.org/project/cscope-manager/)
[![Build Status](https://travis-ci.com/susu9/cscope-manager.svg?branch=master)](https://travis-ci.com/susu9/cscope-manager)
[![Python Compatibility](https://img.shields.io/pypi/pyversions/cscope-manager)](https://travis-ci.com/susu9/cscope-manager)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/susu9/cscope-manager.svg)
![GitHub](https://img.shields.io/github/license/susu9/cscope-manager.svg)
# cscope-manager
Help you manage cscope/ctags tags

# Installation
```shell
pip install csmgr
```

## Screenshot

![example](https://github.com/susu9/cscope-manager/blob/master/screenshot-1.png)

# Custimization
You can create a config file in ~/.csmgr.config to customize your preference
```
# Supported configurations and format
backup_prefix = .tmp.
suffixes = .cpp
out_list = map.files
meta_files = cscope.in.out cscope.out cscope.po.out tags
exclude_dirs = dir
# Note: Only supprot $out_list. Not support other variables interpolation
exec_cmds = cscope -bqk -i $out_list && ctags -a -L $out_list
display_max = 20
delim     = ........................................
delim_end = ****************************************
```

## Features
1. Add files
```shell
$csmgr a.c b.c
```
2. Add folder
```shell
$csmgr dir1/ dir2/
```
3. Remove duplicate file pathes
4. Remove symbolic link

## Usage
```
usage: csmgr [-h] [-o OUT_LIST] [-f] [-r] [-s SUFFIXES [SUFFIXES ...]]
             [-m META_FILES [META_FILES ...]]
             [-e EXCLUDE_DIRS [EXCLUDE_DIRS ...]] [-d] [--dry-run]
             [--max-display MAX_DISPLAY] [-x EXEC_CMDS [EXEC_CMDS ...]]
             [--verbose] [-v]
             [path [path ...]]

positional arguments:
  path                  ex. dir/, file.c

optional arguments:
  -h, --help            show this help message and exit
  -o OUT_LIST, --out-list OUT_LIST
                        assign the name of ouput list file (default:
                        cscope.files)
  -f, --force           delete meta data and generate tag
  -r, --roll-back       roll back list file to the previous version
  -s SUFFIXES [SUFFIXES ...], --suffixes SUFFIXES [SUFFIXES ...]
                        assign suffixes filter (default: .c .h .js .cpp .py)
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
                        -i $out_list && ctags -a -L $out_list)
  --verbose             show more logs
  -v, --version         show program's version number and exit
```
