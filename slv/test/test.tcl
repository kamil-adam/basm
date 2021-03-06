#!/usr/bin/tclsh

lappend ::auto_path ../main 

package require tcltest 2
namespace import tcltest::*

package require logger
set log [logger::init main]

package require tempfile
namespace import ::tempfile::new_init_tempfile

set SLV "../main/slv.tcl"
set BF "bf"

set codefile_bug [new_init_tempfile {
>++++++++[<+++++++++>-]<.>>+>+>++>[-]+<[>[->+<<++++>]<<]>.+++++++..+++.>
>+++++++.<<<[[-]<[-]>]<+++++++++++++++.>>.+++.------.--------.>>+.>++++.
}]

test bf {an example test} -body {
    return [exec $BF $codefile]
} -result "Hello World!"

test slv {an example test} -body {
    return [exec $SLV --noinput -tbf $codefile]
} -result "Hello World!"

test slv-in {an example test} -body {
    return [exec $SLV -tbf -r < $codefile]
} -result "Hello World!"

test slv-cat {an example test} -body {
    return [exec cat $codefile |  $SLV  -tbf -r]
} -result "Hello World!"

test slv-bug {an example test} -body {
    return [exec cat $codefile_bug |  $SLV  -tbf -r]
} -result "Hello World!"




cleanupTests