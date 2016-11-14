#!/usr/bin/env bash

grep -e '^[a-zA-Z]\{4,8\}$' data/words3.txt | tr '[:upper:]' '[:lower:]' | sort -u > data/passphrase-words.txt

function wordfrequency() {
  sort | uniq -c | sort -rn
}

function getArticleText() {
  awk '/<text xml:space="preserve">/,/<\/text>/' | sed -e 's/&quot;/"/g' -e 's/&lt;/</g' -e 's/&gt;/>/g' -e 's/&amp;/&/g' -e 's/<.*>//g'
}

function reduceWikiText() {
  tr -sc '[:alpha:]' '\n' | tr '[:upper:]' '[:lower:]'
}

bzcat data/enwiki-20161020-pages-articles.xml.bz2 | getArticleText | reduceWikiText | grep -Fx -f data/passphrase-words.txt | wordfrequency > data/wordFreqs.txt
