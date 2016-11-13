#!/usr/bin/env bash

grep -e '^[a-zA-Z]\{4,8\}$' data/words3.txt | tr '[:upper:]' '[:lower:]' | sort -u > data/passphrase-words.txt

function wordfrequency() {
  mawk '{ for (i=1; i<=NF; i++) { word = tolower($i); words[word]++ } } END { for (w in words) printf("%3d %s\n", words[w], w) } ' | sort -rn
}

function getArticleText() {
  awk '/<text xml:space="preserve">/,/<\/text>/' | sed 's/<.*>//'
}

function reduceWikiText() {
  tr ' [:punct:]' '[\n*]' | sed '/^$/d' | tr '[:upper:]' '[:lower:]'
}

bzcat data/enwiki-20161020-pages-articles.xml.bz2 | getArticleText | reduceWikiText | grep -F -f data/passphrase-words.txt | wordfrequency > data/wordFreqs.txt
