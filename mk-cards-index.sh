#!/usr/bin/env bash

if [ ! -r 'data/wordFreqs.txt' -o 'data/words3.txt' -nt 'data/wordFreqs.txt' ]
  then
    ./make-wordcount.sh
fi

cut -c 9- < data/wordFreqs.txt | ./maptocards.py > data/cardsWordList.txt
