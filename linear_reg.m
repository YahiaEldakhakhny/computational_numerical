% VARIABLE DECLARATION
n = input("How many data points do you have: ");
x = zeros(1,n);
y = zeros(1,n);
sum_x = 0;
sum_y = 0;
sum_x2 = 0;
sum_xy = 0;

% GET INPUT FROM USER
for i = 1:1:n
  x(i) = input(sprintf("Enter the x co-crdinate of point number %d: ",i ));
  y(i) = input(sprintf("Enter the y co-crdinate of point number %d: ",i ));
  
  % DO CALCULATIONS
  sum_x = sum_x + x(i);
  sum_y = sum_y + y(i);
  sum_x2 = sum_x2 + x(i)^2;
  sum_xy = sum_xy + x(i)*y(i);
endfor

% y = a0 + a1*x
% CALCULATE a0 & a1
% n*a0 + sum_x*a1 = sum_y
% sum_x*a0 + sum_x2*a1 = sum_xy
A = [n sum_x sum_y; sum_x sum_x2 sum_xy];
solution = rref(A);
a0 = solution(1,3)
a1 = solution(2,3)

% CALCULATE S_R, S_T, R^2 & R
s_r = 0;
s_t = 0;
for i = 1:1:n
  s_r = s_r + (y(i)-a0-a1*x(i))^2;
  s_t = s_t + (y(i)-(sum_y/n))^2;
endfor
s_r
s_t
r2 = (s_t - s_r)/s_t
r = sqrt(r2)