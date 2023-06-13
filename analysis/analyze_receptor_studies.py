import os
import pandas as pd
import numpy as np
import analysis_utils as ana
import matplotlib.pyplot as plt

os.makedirs('plots', exist_ok=True)

print('\n * beta1-adrenoceptor *')
adrb1_table, adrb1_perf = ana.analyze_study('adrb1', limits=[-27.5,2.5]) 
print('\n * beta2-adrenoceptor *')
adrb2_table, adrb2_perf = ana.analyze_study('adrb2', limits=[-27.5,2.5]) 
print('\n * adenosine receptor A1 *')
adora1_table, adora1_perf = ana.analyze_study('adora1', merge_by_name=True, combination='min', limits=[-22.5,7.5])
print('\n * adenosine receptor A2A *')
adora2a_table, adora2a_perf = ana.analyze_study('adora2a', merge_by_name=True, combination='min', limits=[-22.5,7.5])
print('\n * delta-opioid receptor *')
oprd1_table, oprd1_perf = ana.analyze_study('oprd1', limits=[-18.5,-3.5])
print('\n * mu-opioid receptor *')
oprm1_table, oprm1_perf = ana.analyze_study('oprm1', limits=[-18.5,-3.5])
print('\n * serotonin receptor 1B *')
htr1b_table, htr1b_perf = ana.analyze_study('htr1b', merge_by_name=True, combination='min', limits=[-27.5,2.5])
print('\n * serotonin receptor 2A *')
htr2a_table, htr2a_perf = ana.analyze_study('htr2a', merge_by_name=True, combination='min', limits=[-27.5,2.5])
print('\n * retinoic acid receptor alpha *')
rara_table, rara_perf = ana.analyze_study('rara', limits=[-37.5,-2.5])
