import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import sklearn.metrics


def auroc(targets, predictions):
    """
    Area under the receiver-operating characteristic curve (AUC-ROC).
    
    """
    return sklearn.metrics.roc_auc_score(targets, predictions)

    
def auprc(targets, predictions):
    """
    Area under the precision-recall curve (AUC-PRC).
    
    """
    return sklearn.metrics.average_precision_score(targets, predictions)


def accuracy(targets, predictions):
    return sklearn.metrics.accuracy_score(targets, predictions)


def performance(data, filename=None):
    
    data = data[data['label']!='-'][data['label']!='M']

    keys_i = [k for k in data.keys() if k[:2] == 'DG' and k[-2:] == ' I']
    keys_a = [k for k in data.keys() if k[:2] == 'DG' and k[-2:] == ' A']
    data_i = np.min( data[keys_i], axis=1 )
    data_a = np.min( data[keys_a], axis=1 )
    
    label = np.array( data['label'] == 'A', dtype=int )
    score = np.array( data_a - data_i, dtype=float )
    predi = np.array( score<0, dtype=int )
    isfin = np.isfinite(score)
    
    predi_out = np.array(['-']*len(predi), dtype=str)
    predi_out[(score<0) * isfin] = 'A'
    predi_out[(score>=0)* isfin] = 'I'
    
    false_a = np.sum( [ (predi[i] == 1 and l == 0) for i, l in enumerate(label) ] )/len(label)
    false_i = np.sum( [ (predi[i] == 0 and l == 1) for i, l in enumerate(label) ] )/len(label)
    true_a  = np.sum( [ (predi[i] == 1 and l == 1) for i, l in enumerate(label) ] )/len(label)
    true_i  = np.sum( [ (predi[i] == 0 and l == 0) for i, l in enumerate(label) ] )/len(label)
    
    auroc_out = auroc(label[isfin], -score[isfin])
    auprc_out = auprc(label[isfin], -score[isfin])
    accur_out = accuracy(label, predi)
    dggap_out = np.min(score[label==0]) - np.max(score[label==1])
    
    auroc_dgi = auroc(label[isfin], data_i[isfin])
    auprc_dgi = auprc(label[isfin], data_i[isfin])
    dggap_dgi = np.min(data_i[label==1]) - np.max(data_i[label==0])
    
    auroc_dga = auroc(label[isfin], -data_a[isfin])
    auprc_dga = auprc(label[isfin], -data_a[isfin])
    dggap_dga = np.min(data_a[label==0]) - np.max(data_a[label==1])

    print('\nRESULTS\n')
    print('True labels:\n', np.array(data['label'], dtype=str))
    print('Predictions:\n', predi_out)
    print('AB-FE diff.:\n', score)

    print('\n METRICS \n')
    if len(np.unique(label)) != 2:
        print(" AUROC DDG: - (only one class)")
        print(" AUPRC DDG: - (only one class)")
    else:
        print(" AUROC DDG: %1.3f"%(auroc_out))
        print(" AUPRC DDG: %1.3f"%(auprc_out))
    print(" DGGap DDG: %1.3f"%dggap_out)
    print("  Accuracy: %1.3f"%accuracy(label, predi))
    print("    True A: %1.3f"%true_a)
    print("    True I: %1.3f"%true_i)
    print("   False A: %1.3f"%false_a)
    print("   False I: %1.3f"%false_i)
    print("------------------") 
    print(" AUROC DGA: %1.3f"%(auroc_dga))
    print(" AUPRC DGA: %1.3f"%(auprc_dga))
    print(" DGGap DGA: %1.3f"%dggap_dga)
    print("------------------") 
    print(" AUROC DGI: %1.3f"%(auroc_dgi))
    print(" AUPRC DGI: %1.3f"%(auprc_dgi))
    print(" DGGap DGI: %1.3f"%dggap_dgi)
    
        
    if filename is not None:
        with open(filename+'_metrics.txt', 'w') as file:   
            if len(np.unique(label)) != 2:
                file.write("   AUROC DDG: - (only one class)\n")
                file.write("   AUPRC DDG: - (only one class)\n")
            else:
                file.write("   AUROC DDG: %1.3f\n"%(auroc_out))
                file.write("   AUPRC DDG: %1.3f\n"%(auprc_out))
            file.write("    Accuracy: %1.3f\n"%accur_out)
            file.write("      True A: %1.3f\n"%true_a)
            file.write("      True I: %1.3f\n"%true_i)
            file.write("     False A: %1.3f\n"%false_a)
            file.write("     False I: %1.3f\n"%false_i)  
            file.write("------------------\n"%false_i) 
            file.write("   AUROC DGA: %1.3f\n"%(auroc_dga))
            file.write("   AUPRC DGA: %1.3f\n"%(auprc_dga))
            file.write("   AUROC DGI: %1.3f\n"%(auroc_dgi))
            file.write("   AUPRC DGI: %1.3f\n"%(auprc_dgi))
            
            
    return auroc_out, auprc_out, dggap_out, accur_out, auroc_dga, auprc_dga, dggap_dga, auroc_dgi, auprc_dgi, dggap_dgi
    

def scatterplot(data, title=None, filename=None, limits=[-27.5,7.5]):

    colormap = {'A':'C1', 'I':'C0'}
    markermap = {'A':'s', 'I':'o'}
    labelmap = {'A':'agon.', 'I':'antag.'}
    
    fig, ax = plt.subplots(1,1, figsize=[3,3], dpi=300)
    labels_in_set = set(data[data['label']!='-']['label'])
    for act_label in labels_in_set:
        keys_i = [k for k in data.keys() if k[:2] == 'DG' and k[-2:] == ' I']
        keys_a = [k for k in data.keys() if k[:2] == 'DG' and k[-2:] == ' A']
        data_i = data[data['label']==act_label][keys_i]
        data_a = data[data['label']==act_label][keys_a]
        ax.plot(
            np.min(data_i, axis=1), 
            np.min(data_a, axis=1), 
            markermap[act_label], 
            color=colormap[act_label], 
            label=labelmap[act_label], 
            alpha=0.5
        )
    # Set dimensions
    ax.set_aspect('equal')
    ax.set_xlim(*limits)
    ax.set_ylim(*limits)
    # Diagonal line
    ax.plot(np.arange(-40,20), np.arange(-40,20), '--', c='black', alpha=0.5)
    # Axis labels
    ax.set_xlabel(r'$\Delta$G inactive [kcal/mol]')
    ax.set_ylabel(r'$\Delta$G active [kcal/mol]')
    # Legend
    ax.legend(loc='best', fontsize=10)
    if title:
        ax.set_title(title)
    fig.tight_layout()
    if filename is not None:
        fig.savefig(filename+'_scatterplot.png', dpi=300)
        fig.savefig(filename+'_scatterplot.pdf', dpi=300)
    

def barplot(data, use_index=None, filename=None):
    
    data = data[data['label']!='-'].sort_values('DDG')
    
    fig, ax = plt.subplots(1, 1, figsize=[4,3], dpi=300)
    
    bar_color = {'I':'C0', 'A':'C1'}
    bar_label = {'I':'antagonists', 'A':'agonists'}
    bar_label_set = {'I':False, 'A':False}
    # Define the lookup table
    table = pd.DataFrame([], columns = ['rank','ligand','label','DDG','DG(I)','DG(A)'])
    # Iterate through the sorted ligands to plot a bar and add a line to the lookup table
    for new_index, line in enumerate(data[['ligand','label','DDG','DG(I)','DG(A)']].itertuples()):
        # Get all quantities needed
        index, ligand, lig_label, ddg, dgi, dga = line  
        # Add a line to the lookup table
        to_add = [[new_index+1, ligand, lig_label, ddg, dgi, dga]]
        new_line = pd.DataFrame(to_add, columns = table.columns)
        table = table.append(new_line, ignore_index=True)
        # Add a label to appear in the legend to the first bar of each class 
        if bar_label_set[lig_label]:
            blabel = None
        else:
            blabel = bar_label[lig_label]
            bar_label_set[lig_label] = True
        # Define how the x axis will be labeled
        if use_index is None:
            x_value = ligand
        elif use_index == 'original':
            x_value = f'%i'%index
        elif use_index == 'sorted':
            x_value = f'%i'%(new_index+1)
        # Plot the bar for this ligand
        ax.bar(x_value, ddg, color=bar_color[lig_label], label=blabel)
    # Format the figure and add labels
    plt.xticks(rotation=90)
    ax.set_ylabel('$\Delta\Delta$G [kcal/mol]')
    ax.tick_params(axis='x', which='major', labelsize=6)
    ax.legend(loc='best')
    fig.tight_layout()   
    if filename is not None:
        fig.savefig(filename+'_barplot.png', dpi=300)
        fig.savefig(filename+'_barplot.pdf', dpi=300)
        table.to_csv(filename+'_table.csv', index=False)
    return table
    
    
def reorder_by_name(input_data, combination='avg'):
    
    data = input_data.copy()
    data['lig_name'] = [lig.split(' - ')[-1] for lig in data['ligand']]
    data['lig_name'] = [lig.split('_Var')[0] for lig in data['lig_name']]

    lig_names = np.unique(data['lig_name'])
    labels = np.array([ list(data[data['lig_name'] == name]['label'])[0] for name in lig_names ])
    new_data = pd.DataFrame(np.transpose(np.array([lig_names, labels])), columns=['ligand','label'])
    
    cl_names = [k[3:] for k in data.keys() if k[:2] == 'DG' and k[-2:] in [' I',' A']]
    clusters = {cln: cln[-1] for cln in cl_names}
    for cl_name in clusters:
        dg = np.empty(len(lig_names))
        sigma = np.empty(len(lig_names))
        for i,name in enumerate(lig_names):
            lig_dg = data[data['lig_name']==name][f"DG {cl_name}"]
            lig_sigma = data[data['lig_name']==name][fr"$\sigma$ {cl_name}"]
            if combination == 'avg':
                dg[i] = np.mean(lig_dg)
            elif combination == 'min':
                dg[i] = np.min(lig_dg)
            else:
                print('Invalid combination rule!')
                return
            sigma[i] = np.max(lig_sigma)
        new_data[f"DG {cl_name}"] = dg
        new_data[fr"$\sigma$ {cl_name}"] = sigma
    
    return new_data


def write_to_xlsx(data, name):   
    xlsx_a = name+'_agonists.xlsx'
    xlsx_i = name+'_antagonists.xlsx'
    data[data.label=='A'].to_excel(xlsx_a)
    data[data.label=='I'].to_excel(xlsx_i)
    
    
def calculate_ddg(input_data):
    data = input_data.copy()
    col = data.columns
    col_a = col[[c[:2]=="DG" and c[-1]=='A' for c in col]]
    col_i = col[[c[:2]=="DG" and c[-1]=='I' for c in col]]
    data['DG(A)'] = data[col_a].min(axis=1)
    data['DG(I)'] = data[col_i].min(axis=1)
    data['DDG'] = data['DG(A)'] - data['DG(I)']
    return(data)


