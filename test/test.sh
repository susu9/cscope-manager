#!/bin/bash
# Usage: shunit2 test/test.sh

checkDelete() {
    files=$1
    for file in $files; do
        if [ -e $file ]; then
            assertNotEquals 0 $? 
        fi
    done
}

testBasic() {
    python csmgr -h
    assertEquals 0 $? 
    python csmgr -v
    assertEquals 0 $? 
}

testFile() {
    python csmgr test/file1.c
    assertEquals 0 $? 
    grep -w test/file1.c cscope.files
    assertEquals 0 $? 
    python csmgr -d
    checkDelete "cscope.in.out cscope.out cscope.po.out tags"
    rm .csmgr.project
}

testForce() {
    python csmgr test/file1.c
    assertEquals 0 $? 
    python csmgr -f
    assertEquals 0 $? 
    python csmgr -d
    rm .csmgr.project
}

testDir() {
    python csmgr test/dir
    assertEquals 0 $? 
    grep -w test/dir/dir_file1.c cscope.files
    assertEquals 0 $? 
    grep -w test/dir/dir_file2.c cscope.files
    assertEquals 0 $? 
    python csmgr -d
    rm .csmgr.project
}

testSuffix() {
    python csmgr . -s .cpp
    assertEquals 0 $? 
    grep -w test/dir/dir_file1.c cscope.files
    assertNotEquals 0 $? 
    grep -w test/dir/dir_file2.c cscope.files
    assertNotEquals 0 $? 
    grep -w test/file2.cpp cscope.files
    assertEquals 0 $? 
    python csmgr -d
    rm .csmgr.project
}

testList() {
    python csmgr test/file1.c -o src.map 
    assertEquals 0 $? 
    grep -w test/file1.c src.map
    python csmgr -d
    rm .csmgr.project
}

testMeta() {
    python csmgr . 
    assertEquals 0 $? 
    python csmgr -d -m cscope.files cscope.in.out cscope.out cscope.po.out tags .csmgr.project
    checkDelete "cscope.in.out cscope.out cscope.po.out tags .csmgr.project"
}

testCmd() {
    python csmgr test/file1.c -x 'echo "test/dir/dir_file1.c"' 'echo "test/dir/dir_file2.c"' > cmd.out
    grep -w test/dir/dir_file1.c cmd.out
    assertEquals 0 $? 
    grep -w test/dir/dir_file2.c cmd.out
    assertEquals 0 $? 
    python csmgr -d
    rm .csmgr.project
}

CONFIG_FILE='test/.csmgr.config'

testExclude() {
    python csmgr -c $CONFIG_FILE  test -e dir/
    grep -w test/dir/dir_file1.c cscope.files
    assertNotEquals 0 $? 
    grep -w test/dir/dir_file2.c cscope.files
    assertNotEquals 0 $? 
    python csmgr -c $CONFIG_FILE -d
    rm .csmgr.project
}

testSuffix2() {
    python csmgr -c $CONFIG_FILE .
    assertEquals 0 $? 
    grep -w test/dir/dir_file1.c map.files
    assertNotEquals 0 $? 
    grep -w test/dir/dir_file2.c map.files
    assertNotEquals 0 $? 
    grep -w test/file2.cpp map.files
    assertEquals 0 $? 
    python csmgr -c $CONFIG_FILE -d
    rm .csmgr.project
}

testExclude2() {
    python csmgr -c $CONFIG_FILE test
    grep -w test/dir/dir_file1.c map.files
    assertNotEquals 0 $? 
    grep -w test/dir/dir_file2.c map.files
    assertNotEquals 0 $? 
    python csmgr -c $CONFIG_FILE -d
    rm .csmgr.project
}

