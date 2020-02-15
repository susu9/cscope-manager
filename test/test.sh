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
    echo y | python csmgr -d
    rm cscope.files
    checkDelete "cscope.in.out cscope.out cscope.po.out tags"
}

testForce() {
    python csmgr test/file1.c
    assertEquals 0 $? 
    python csmgr -f
    assertEquals 0 $? 
    echo y | python csmgr -d
    rm cscope.files
}

testDir() {
    python csmgr test/dir
    assertEquals 0 $? 
    grep -w test/dir/dir_file1.c cscope.files
    assertEquals 0 $? 
    grep -w test/dir/dir_file2.c cscope.files
    assertEquals 0 $? 
    echo y | python csmgr -d
    rm cscope.files
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
    echo y | python csmgr -d
    rm cscope.files
}

testList() {
    python csmgr test/file1.c -o src.map 
    assertEquals 0 $? 
    grep -w test/file1.c src.map
    echo y | python csmgr -d
    rm src.map
}

testMeta() {
    python csmgr . 
    assertEquals 0 $? 
    echo y | python csmgr -d -m cscope.files cscope.in.out cscope.out cscope.po.out tags 
    checkDelete "cscope.files cscope.in.out cscope.out cscope.po.out tags"
}

testCmd() {
    python csmgr test/file1.c -x 'echo "test/dir/dir_file1.c"' 'echo "test/dir/dir_file2.c"' > cscope.files
    grep -w test/dir/dir_file1.c cscope.files
    assertEquals 0 $? 
    grep -w test/dir/dir_file2.c cscope.files
    assertEquals 0 $? 
    echo y | python csmgr -d
    rm cscope.files
}

testExclude() {
    init_config
    python csmgr test -e dir/
    grep -w test/dir/dir_file1.c cscope.files
    assertNotEquals 0 $? 
    grep -w test/dir/dir_file2.c cscope.files
    assertNotEquals 0 $? 
    echo y | python csmgr -d
    rm cscope.files
}

init_config() {
    if [ ! -e ~/.csmgr.config ]; then
        sudo cp -a test/.csmgr.config ~/ 
    fi
}

testSuffix2() {
    init_config
    python csmgr .
    assertEquals 0 $? 
    grep -w test/dir/dir_file1.c map.files
    assertNotEquals 0 $? 
    grep -w test/dir/dir_file2.c map.files
    assertNotEquals 0 $? 
    grep -w test/file2.cpp map.files
    assertEquals 0 $? 
    echo y | python csmgr -d
    rm map.files
}

testExclude2() {
    init_config
    python csmgr test
    grep -w test/dir/dir_file1.c map.files
    assertNotEquals 0 $? 
    grep -w test/dir/dir_file2.c map.files
    assertNotEquals 0 $? 
    echo y | python csmgr -d
    rm map.files
}

