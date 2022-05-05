% VARIABLE DECLARATION
n = input("How many data points do you have: ");
x = zeros(1,n);
y = zeros(1,n);

% GET INPUT FROM USER
for i = 1:1:n
  x(i) = input(sprintf("Enter the x co-crdinate of point number %d: ",i ));
  y(i) = input(sprintf("Enter the y co-crdinate of point number %d: ",i ));
endfor
