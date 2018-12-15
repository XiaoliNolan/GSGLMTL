# Group Guided Sparse Group Lasso Multi-task Learning (GSGL-MTL) #

This repository contains a MATLAB implementation of the GSGL-MTL algorithm proposed in the paper [Group Guided Sparse Group Lasso Multi-task Learning for Cognitive Performance Prediction of Alzheimer’s Disease](https://link.springer.com/chapter/10.1007/978-3-319-70772-3_19).

## Overview ##

The Group guided Sparse Group Lasso regularized multi-task learning (GSGL-MTL) algorithm exploits both the group structure of features and the multi-task correlation, to unify feature-level and ROI-level analysis in an unified multi-task learning framework. An Alternating Direction Method of Multipliers (ADMM) based optimization is developed to effciently solve the non-smooth formulation. 

This code has been tested only in MATLAB in both Linux and Mac.

## How to run? ##

We created the file `GSGL_MTL.m` to show how to run GSGL-MTL code. 

## Structure of the input data files ##

In order to run the code the input data files containing the training and test data must follow a specific format. 
The `ADMM()` function, which is the core algorithm of GSGL-MTL, receives two matrices, **X** (covariate matrix) *n x p* with the number of *n* samples and *p* covariates, and **Y** (response matrix) *n x k* with *k* tasks; and group information vector with *p* covariates divided *q* disjoint groups. Note that, the number of features in each group can be different.

## How to cite it? ##

If you like it and want to cite it in your papers, you can use the following:

```
#!latex

@inproceedings{liu2017group,
  title={Group Guided Sparse Group Lasso Multi-task Learning for Cognitive Performance Prediction of Alzheimer’s Disease},
  author={Liu, Xiaoli and Cao, Peng and Zhao, Dazhe and Zaiane, Osmar and others},
  booktitle={International Conference on Brain Informatics},
  pages={202--212},
  year={2017},
  organization={Springer}
}
```

## Have a question? ##

If you found any bug or have a question, don't hesitate to contact me:

[Xiaoli Liu]
email: `neuxiaoliliu -at- gmail -dot- com`





