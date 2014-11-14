model = arima('Constant',0,'AR',{0.5},'Variance',1);
n = 1000;
processes = simulate(model,n,'numPaths',2);
X = processes(:,1);
Y = processes(:,2);


%these are independent - test should accpet i.e. reject=0 (keep in mind that the 
%null hypothesis rejection rate is 5% )
wildHSIC(X,Y)

%same function with non-default parameters and proceess with different
%distibutions. Test should reject i.e. reject=1
wildHSIC(X,X+Y,'TestType',1,'Alpha',0.01,'NumBootstrap',500)

disp('Now MMD')

%these are the same. Reject should be 0.
wildMMD(X,Y)

%same function with non-default parameters and proceess with different
%distibutions. Reject should be 1.
wildMMD(X,2*Y,'TestType',2,'Alpha',0.01,'NumBootstrap',500)


