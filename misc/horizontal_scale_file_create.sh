#!/bin/bash

set -e

N="$1"
if [ -z "$N" ]; then
    N=1
fi

function do_scale_test {
    T=$(mkdir /cephfs-$N)
    cd "$T"
    for ((i = 0; i < 100; ++i)); do
      mkdir "$i"
      while j <= 9000; do
        mkdir "$i/$j"
	j++
    rm -rfv "$T"
}

{
    count=0
    while true; do
        if systemctl status ceph-fuse@-cephfs || [ "$(stat -f --format=%t /cephfs)" = c36400 ]; then
            break # shell ! is stupid, can't move to while
        fi
        sleep 5
        if ((++count > 60)); then
            exit 1
        fi
    done

    for ((i = 0; i < N; ++i)); do
        do_scale_test &> /root/client-output-$i.txt &
    done
    wait
} > /root/client-output.txt 2>&1
