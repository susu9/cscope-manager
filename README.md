[![Pypi version](https://img.shields.io/pypi/v/cscope-manager)](https://pypi.org/project/cscope-manager/)
[![Build Status](https://travis-ci.com/susu9/cscope-manager.svg?branch=master)](https://travis-ci.com/susu9/cscope-manager)
[![Python Compatibility](https://img.shields.io/pypi/pyversions/cscope-manager)](https://travis-ci.com/susu9/cscope-manager)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/susu9/cscope-manager.svg)
![GitHub](https://img.shields.io/github/license/susu9/cscope-manager.svg)
# cscope-manager
A tool helps you manage cscope/ctags tags

![cscope-manager-demo-small](https://user-images.githubusercontent.com/6793352/90326615-40b8ad80-df3f-11ea-959d-2012d688e22a.gif)

## Installation
```shell
pip install cscope-manager
```

## Custimization
You can create a config file in ~/.csmgr.config to customize your preference
```
# Supported configurations and format
project_list = .csmgr.project
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

## Features
1. Generate file list (cscope.files) for cscope/ctags through a customize project list (.csmgr.project)
2. Remove duplicate file pathes in cscope.files
3. Remove symbolic link in cscope.files
4. Remove not existed files in cscope.files
5. Check redudant path in project list

## Usage
```
usage: csmgr [-h] [-u] [-f] [-s SUFFIXES [SUFFIXES ...]] [-c CONFIG_FILE]
             [-o OUT_LIST] [-m META_FILES [META_FILES ...]]
             [-e EXCLUDE_DIRS [EXCLUDE_DIRS ...]] [-d] [--dry-run]
             [--max-display MAX_DISPLAY] [-x EXEC_CMDS [EXEC_CMDS ...]]
             [--verbose] [-v]
             [path [path ...]]

positional arguments:
  path                  add path to project list (.csmgr.project) and run
                        commands for tag generation if cscope.files is changed
                        ex. dir/, file.c

optional arguments:
  -h, --help            show this help message and exit
  -u, --update          Update cscope.files if necessary and run commands for
                        tag generation
  -f, --force           delete meta data and run commands for tag generation
  -s SUFFIXES [SUFFIXES ...], --suffixes SUFFIXES [SUFFIXES ...]
                        assign suffixes filter (default: .c .h .js .cpp .py
                        .scss .css .java)
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
                        assign commands for tag generation. $out_list will be
                        replaced by list file name (check -o for details).
                        (default: cscope -bqk -i $out_list && ctags -L
                        $out_list)
  --verbose             show more logs
  -v, --version         show program's version number and exit
```
