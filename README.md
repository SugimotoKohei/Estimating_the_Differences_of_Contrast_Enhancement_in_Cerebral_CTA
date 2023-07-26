# Estimating the differences between inter-operator contrast enhancement in cerebral CT angiography

This repository contains the source code for the Bayesian statistical model used in the research paper titled "Estimating the differences between inter-operator contrast enhancement in cerebral CT angiography" by Kohei Sugimoto, Yuta Fujiwara, Masataka Oita, and Masahiro Kuroda, published in *Med Phys.*  2023 (doi: [10.1002/mp.16549](https://aapm.onlinelibrary.wiley.com/doi/10.1002/mp.16549), PMID: [37293888](https://pubmed.ncbi.nlm.nih.gov/37293888/)).

## Contained code

The repository includes two source code files:

- [hierarchical_linear_model.stan](https://github.com/SugimotoKohei/Estimating_the_Differences_of_Contrast_Enhancement_in_Cerebral_CTA/blob/main/model/hierarchical_linear_model.stan)
- [hierarchical_sigmoid_model.stan](https://github.com/SugimotoKohei/Estimating_the_Differences_of_Contrast_Enhancement_in_Cerebral_CTA/blob/main/model/hierarchical_sigmoid_model.stan)

*Note*: The authors recommend using  the `hisrarchical_sigmoid_model.stan`  because this model demonstrated superior performance. Further details can be found in the research paper.
