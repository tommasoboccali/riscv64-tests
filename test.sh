#!/bin/bash
a="0.002"
b="333"
let c="$a * $b"
c=$(awk "BEGIN {print $a*$b; exit}")

echo $a $b $c
