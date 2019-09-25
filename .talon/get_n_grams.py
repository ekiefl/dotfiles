#!/usr/bin/env python
# -*- coding: utf-8
'''
This code prints the n-grams of phrases that are spoken within a certain timeframe of one another.
For example if you say 'odd tap' and then less than three seconds later say 'print', this
concatenates those commands into the single command 'odd tap print'. Then the 2-grams for this link
command would be ['odd tap', 'tap print']. It prints the number of times you've spoken each
command if that value is greater than three. The code is read from the file phrase_log in the Talon
home directory, which is generated with my version of last_phrase.py. For the sake of security,
phrases that only have numbers are not recorded because from this you could piece together credit
card numbers, telephone numbers, addresses, etc.
'''

import os
import sys
import pyphen # syllable counter
import argparse

import pandas as pd

from pathlib import Path
from datetime import datetime
from datetime import timedelta

min_occurrence_help = """
    Do not print phrases occurring less than this number of times. The default is 3.
"""
maximum_linkage_time_help = """
    Commands occurring within this many seconds are concatenated together. Otherwise they are
    treated as full commands. The default is 3 seconds.
"""
maximum_ngrams = """
    How many ngrams do you want to calculate out to. The default is six.
"""

ap = argparse.ArgumentParser()
ap.add_argument('--minimum-occurrence', '-m', default=3, type=int, help=min_occurrence_help)
ap.add_argument('--maximum-linkage-time', '-l', default=3, type=int, help=maximum_linkage_time_help)
ap.add_argument('--maximum-ngrams', '-n', default=6, type=int, help=maximum_ngrams)
args = ap.parse_args()

TALON_HOME = os.path.join(str(Path.home()), '.talon')
PHRASE_LOG = os.path.join(TALON_HOME, 'phrase_log')

df = pd.read_csv(PHRASE_LOG, sep='\t', names=['timestamp', 'phrase'])
df['timestamp'] = pd.to_datetime(df['timestamp'])

linked_commands = []
previous_timestamp = datetime(1800, 1, 1)
back_to_back_phrases = []

for _, row in df.iterrows():
    if row['timestamp'] - previous_timestamp > timedelta(seconds = args.maximum_linkage_time):
        linked_commands.append(' '.join(back_to_back_phrases))
        back_to_back_phrases = []
    back_to_back_phrases.append(row['phrase'])
    previous_timestamp = row['timestamp']

n_grams = {n: {} for n in range(1, args.maximum_ngrams + 1)}
for linked_command in linked_commands:
    words = linked_command.split(' ')

    for n in n_grams:
        if n > len(words):
            break

        for i in range(len(words) - n):
            n_gram = ' '.join(words[i: i + n])
            if n_gram not in n_grams[n]:
                n_grams[n][n_gram] = 1
            else:
                n_grams[n][n_gram] += 1

try:
    os.mkdir('n_grams')
except:
    pass

for n in n_grams:
    df = pd.DataFrame({'counts': list(n_grams[n].values()),
                       'n_gram': list(n_grams[n].keys())})
    df.sort_values(by='counts', ascending=False).to_csv(os.path.join('n_grams', '{}_grams.txt'.format(n)), sep='\t', index=False)
