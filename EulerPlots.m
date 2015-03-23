clear all
xList=load('/Users/MathematicianVogt/Desktop/fortran/eulerx.txt');
yList=load('/Users/MathematicianVogt/Desktop/fortran/eulery.txt');
errorList=load('/Users/MathematicianVogt/Desktop/fortran/eulererror.txt');

sqr = @(x) x.^2;

plot(xList,sqr(xList),xList,yList,xList,errorList)
title('Euler method for dy/dx=2x')
xlabel('x') % x-axis label
ylabel('f(x)') % y-axis label
legend('Actual Solution','Numerical Solution','Error')
