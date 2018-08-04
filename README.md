# cscope-manager
This is a simple script to help you create cscope.files and run cscope and ctags command.

## Screenshot

![example](https://github.com/susu9/cscope-manager/blob/master/screenshot-1.png)

## Features
1. Add files
```shell
$csmgr a.c b.c
```
2. Add folder
```shell
csmdr my_src/
```
3. Remove duplicate file pathes
4. Remove symbolic link

## Usage
```shell
Usage: /Users/rickchang/bin/csmgr [-f | -d | -h] <dir | file>...
  -f: forcely regenerate tags from cscope.files
  -r: recover tags to the last change
  -d: delete all meta data except for cscope.files
  -h: detailed information for arguments
```
