model = arima('Constant',0,'AR',{0.5},'Variance',1);
n = 1000;
processes = simulate(model,n,'numPaths',2);
X = processes(:,1);
Y = processes(:,2);


%these are independent (keep in mind that the test might reject the null hypothesis with probability 5% )
mmd(X,Y)

%same function with non-default parameters and dependent processes  
mmd(X,Y+X,'TestType',2,'Alpha',0.01,'NumBootstrap',500)
