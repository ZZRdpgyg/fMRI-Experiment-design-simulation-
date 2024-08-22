# -*- coding: utf-8 -*-
"""
Created on Mon Dec  4 11:31:46 2023

@author: ziruiz
"""

import random
import numpy as np
import os
import csv
path = './'
filename = '4_8_test.txt'
logFile = open(path + filename, 'w')
logFile.write('onset\tevent\n')
print('onset\tevent')

int_sequence = [x for x in range(5,12) for y in range(6)] + [5,6,7,9,10,11]# ISI from s to s average s
#int_sequence = [12 for y in range(48)]# ISI from 5s to 7s average 6s
random.shuffle(int_sequence)
int_sequence = int_sequence + [12, 12, 12]

cond_list = ['Office_Novelty','Office_Repeat','Office_8', 'City_Novelty','City_Repeat','City_8'] * 8

con = ['fixtation'] + cond_list +['target','border','surround']
isi_i = 0
N = 0 
for i in con:
    if i == 'fixtation':
        logFile.write(str(N) + '\tfixation\n')
        N = N + 6
    elif i in ['target','border','surround']:
        ISI = int_sequence[isi_i]
        isi_i += 1
        logFile.write(str(N) + '\t' + str(i) + '\n')
        N = N + 12 + ISI 
    elif i not in ['target','border','surround']:
        ISI = int_sequence[isi_i]
        isi_i += 1
        logFile.write(str(N) + '\t' + str(i) + '\n')
        N = N + 4 + ISI #presentation time
        

logFile.close()
