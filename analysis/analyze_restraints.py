import os
import pandas as pd
import numpy as np
import analysis_utils as ana
import matplotlib.pyplot as plt

os.makedirs('plots', exist_ok=True)

print('\n * ADRB2 Restrained vs. Unrestrained *')
data_res = ana.calculate_ddg(pd.read_csv('../results/adrb2.csv'))
data_unr = ana.calculate_ddg(pd.read_csv('../results/adrb2-unrestrained.csv'))
print('\n - ADRB2 Restrained vs. Unrestrained -')
performance = ana.performance(data_unr, filename=None) # already saved previously
print('\n - ADRB2 Restrained vs. Unrestrained -')
performance = ana.performance(data_unr, filename='plots/adrb2-unrestrained') 
table = ana.barplot(data_unr, use_index='sorted', filename='plots/adrb2-unrestrained')
ana.scatterplot(data_res, limits=[-27.5,-2.5], filename='plots/adrb2-unrestrained')
ana.scatterplot(data_unr, limits=[-27.5,-2.5], filename='plots/adrb2-restrained')

print('\n * Restraints from MD Simulations vs. Restraints to PDB Structures *')
data_mds = ana.calculate_ddg(pd.read_csv('../results/oprd1.csv'))
data_pdb = ana.calculate_ddg(pd.read_csv('../results/oprd1-pdb.csv'))
print('\n - OPRD1 with Restraints from MD Simulations -')
performance = ana.performance(data_mds, filename=None) # already saved previously
print('\n - OPRD1 with Restraints to PDB Structures -')
performance = ana.performance(data_pdb, filename='plots/oprd1-pdb') 
table = ana.barplot(data_pdb, use_index='sorted', filename='plots/oprd1-pdb')
ana.scatterplot(data_mds, limits=[-22.5,-2.5], filename='plots/oprd1-mds')
ana.scatterplot(data_pdb, limits=[-22.5,-2.5], filename='plots/oprd1-pdb')