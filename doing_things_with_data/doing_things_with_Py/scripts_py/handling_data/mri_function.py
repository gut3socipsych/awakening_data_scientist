import itertools, numpy as np, pandas as pd

def mri_selectone(data, response_labels = None, combined_variable_name = "new"):
    data[data != 1] = 0
    results = []
    for i in range(data.shape[0]):
        results.append(format(data.iloc[i][data.iloc[i] == data.iloc[i].max()].keys()[0]))

    results = pd.DataFrame(data = results, columns = [combined_variable_name])
    return(results)

def mri(data, combined_variable_name = "new"):
    #function objects#
    colnum = data.shape[1]

    #categorize choices#
    choice_perm = pd.DataFrame(list(itertools.product(range(1, colnum+1), repeat = 4)))-1
    choice_code = []
    choice_name = []
    for n in range(data.shape[1]):
        for p in range(choice_perm.shape[0]):
            choice_base = np.repeat("0", data.shape[1])
            choice_base[list(choice_perm.iloc[p])] = "1"
            choice_code.append("".join(choice_base))
            choice_name.append(" & ".join(set(data.columns[list(choice_perm.iloc[p])])))

    choice_cats = dict(zip(choice_code, choice_name))

    #results#
    response_code = []
    for r in range(data.shape[0]):
        response_code.append("".join([str(data.iloc[r][i]) for i in range(len(data.iloc[r]))]))
    response_factor = []
    [response_factor.append(choice_cats[i]) for i in response_code]

    data[combined_variable_name] = response_factor

    return(data)
