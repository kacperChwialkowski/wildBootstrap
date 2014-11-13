%  Kacper Chwialkowski
%  Maximum mean discrepancy (MMD) kernel two-sample tests for random
%  processes. 
%  RESULTS = MMD(X,Y,varargin) runs the wild bootstrap mmd test which
%  verifies the hypothesis that X has the same distribution as Y. The wild
%  bootstrap test comes in two flavors, both consistent. For the details
%  see 'A Wild Bootstrap for Degenerate Kernel Tests' http://arxiv.org/abs/1408.5404
%
%   ARGUMENTS
%   
%   X and Y are arrays of the observations. Each row contains a single
%   observation, each column contains single dimension of all observations.
%   X and Y must contain the same number of observations.
%   
%   varargin can be any of the following:
%       'Test' : if 1 the fist flavor of the test is used, if 
%        2 the second flavor is used. Default is value is 1.   
%       'Alpha' : test level, default value is 0.05
%       'Kernel': function that takes two arrays X,Y, both of dimension m 
%        by d and returns kernel matrix K of size m by m such that 
%        K(i,j) = k(X(i,:),Y(j,:)) where k is a kernel function. See
%        rbf_dot for the default implementation.
%       'WildBootstrap': function that returns wild bootstrap process.
%        See bootstrap_series in util directory for the default
%        implementation
%       'NumBootstrap' : number of bootstrap re-sampling. Default value is
%        300
%  
%   RESULTS contains the following fields:
%       testStat : the value of test statistic.
%       quantile : test critical value
%       reject  : null hypothesis can be rejected by the test     
function results = mmd(X,Y,varargin)
addpath('util')

okargs =   {'TestType','Alpha', 'Kernel' ,'WildBootstrap','NumBootstrap'};
defaults = {true,0.05, rbf_dot(X,Y),@bootstrap_series, 300};
    [test_type,alpha, kernel,wild_bootstrap, numBootstrap] = ...
        internal.stats.parseArgs(okargs, defaults, varargin{:});  


m=size(X,1);

assert(m == size(X,1))
assert(test_type==1 || test_type==2)
K = kernel(X,X);
L = kernel(Y,Y);
M = kernel(X,Y);
processes = wild_bootstrap(m,numBootstrap);

statMatrix = K+L-2*M;
testStat = m*mean2(statMatrix);

testStats = zeros(numBootstrap,1);
for process = 1:numBootstrap
    mn = mean(processes(:,process));
    if test_type==1
        matFix = (processes(:,process)-mn)*(processes(:,process)-mn)';
    else
        matFix = processes(:,process)*processes(:,process)';
    end
    testStats(process) =  m*mean2(statMatrix.*matFix );
end

results.testStat = testStat;
results.quantile = quantile(testStats,1-alpha);
results.reject = testStat > results.quantile;

end

