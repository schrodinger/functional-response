import os
import pandas as pd
import numpy as np
import analysis_utils as ana
import matplotlib.pyplot as plt

os.makedirs('plots', exist_ok=True)

print('\n * Original ATOM3D Poses *')
dora1_table, adora1_perf = ana.analyze_study('adora1-atom3d', merge_by_name=True, 
                                             combination='min', limits=[-22.5,7.5]
                                            )
print('\n * MCS-Docked Poses *')
adrb2_table, adrb2_perf = ana.analyze_study('adrb2', limits=[-27.5,2.5]) 
adora1_table, adora1_perf = ana.analyze_study('adora1-atom3d-mcs', merge_by_name=True, 
                                              combination='min', limits=[-22.5,7.5]
                                             )