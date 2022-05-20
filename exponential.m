n = input("How many data points do you have: ");
i = zeros(1,n);
j = zeros(1,n);
for c = 1:1:n
  i(c) = input(sprintf("Enter the x co-ordinate of point number %d: ",c ));
  j(c) = input(sprintf("Enter the y co-ordinate of point number %d: ",c ));
end
%i = [0,1,2,3,4,5];
%j = [1.98, 0.6, 0.25, 0.1, 0.027, 0.011];
k = log (j);
b = 0 ; d =0;
% coefficients of linearized model
[a0, a1] = linear_reg_fun(i,k);
% coefficients of y = a*e^(bx)
a = exp(a0)
b = a1
