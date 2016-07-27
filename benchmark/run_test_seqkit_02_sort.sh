#!/bin/sh

echo Test: Sorting by length

echo warm-up
for f in dataset_{A,B}.fa; do echo data: $f; cat $f > t; /bin/rm t; done

echo delete old FASTA index file
for f in dataset_{A,B}.fa; do
    if [[ -f $f.seqkit.fai ]]; then
        /bin/rm $f.seqkit.fai
        # seqkit faidx $f --id-regexp "^(.+)$" -o $f.seqkit.fai;
    fi;
done


echo == seqkit
for f in dataset_{A,B}.fa; do
    echo data: $f;
    memusg -t -H seqkit sort -l -2 $f > $f.seqkit.sort;
    # seqkit stat $f.seqkit.rc;
    /bin/rm $f.seqkit.sort;
done
