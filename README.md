Wild bootstrap Kernel Tests
====
Two kernel test are implemented in this package

* **MMD** Maximum mean discrepancy kernel two-sample test. 
* **HSIC** Hilbert Schmidt Independence Criterion  - independence test.

The wild bootstrap MMD test verifies the hypothesis that X has the same distribution as Y. The wild bootstrap HSIC test verifies the hypothesis that X and Y are independent. For the details see 'A Wild Bootstrap for Degenerate Kernel Tests' http://arxiv.org/abs/1408.5404. See example.m for the sample code.

Syntax
---
Both tests share the same syntax
```
RESULTS = wildMMD(X,Y)
RESULTS = wildMMD(X,Y,Name,Value)
```
```
RESULTS = wildHSIC(X,Y)
RESULTS = wildHSIC(X,Y,Name,Value)
```
**Arguments**

X and Y are arrays of the observations. Each row contains a single observation, each column contains single dimension of all observations. X and Y must have the same number of observations.

The named arguments can be any of:

+ **'Test'** : if 1 the first flavor of the test is used, if 2 the second flavor is used - the differences between flavors are described in 'A Wild Bootstrap for Degenerate Kernel Tests'. The default is value is 1.   
* **'Alpha'** : test level, default value is 0.05.
* **'Kernel'**: function that takes two arrays X,Y, both of dimension m by d, and returns kernel matrix K of size m by m such that K(i,j) = k(X(i,:),Y(j,:)) where k is a kernel function. See rbf_dot for the default implementation.
* **'WildBootstrap'**: function that returns wild bootstrap process. See bootstrap_series function in util directory for the default implementation.
* **'NumBootstrap'** : number of bootstrap re-sampling. Default value is 300.
  
**Output**
The Output RESULTS contains the following fields:
* **testStat** : the value of test statistic.
* **quantile** : test critical value.
* **reject**  : 1 iff null hypothesis is rejected by the test.
