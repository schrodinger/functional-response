# Functional Response Modeling

Supporting materials for our functional response paper ([Vögele et al., JCTC 2023](https://doi.org/10.1021/acs.jctc.3c00899)): analysis code, machine-readable results, and FEP starting poses. The code to determine the restraints from the MD simulations and to apply them to FEP+ is maintained at [its own repository](https://github.com/schrodinger/fep-restraints).

The analysis code in the folder `analysis` reads the results and labels from the folder `results` and reproduces the plots from the manuscript.
For each target, we provide the FEP starting poses as Maestro files (.mae) and, where applicable, the files defining the restraints in CMS format in the folder `setup`. The commands to run the analysis of the template MD simulations from which we defined the restraints are provided in `templates`.

We have investigated the following receptors:
- ADRB1 - beta1-adrenoceptor
- ADRB2 - beta2-adrenoceptor
- ADORA1 - adenosine receptor A1
- ADORA2A - adenosine receptor A2A
- OPRD1 - delta-opioid receptor
- OPRM1 - mu-opioid receptor
- HTR1B - serotonin receptor 1B
- HTR2A - serotonin receptor 2A
- RARA - retinoic acid receptor alpha
