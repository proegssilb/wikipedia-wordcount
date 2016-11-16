#!/usr/bin/env python3

import sys
import itertools as it

"""
Accept a wordlist from stdin, and map it to sets of cards, as drawn from a
standard deck of 52 playing cards.
"""

def gencards(numberPerSet):
    ranks = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
    suits = ['c', 'd', 's', 'h']
    deck = (r+s for s in suits for r in ranks)
    return it.permutations(deck, numberPerSet)

def getWordlist(cardsPerSet):
    return zip(gencards(cardsPerSet), sys.stdin)

if __name__ == '__main__':
    for cards, word in getWordlist(3):
        print('{0:12}{1}'.format(' '.join(cards), word.strip()))
