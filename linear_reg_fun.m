% THIS FILE DOES EXACTLY THE SAME THING AS THE LINEAR_REG FILE BUT THIS IS A
% FUNCTION THAT WE CAN USE DIRECTLY IN OTHER FILES IN THE SAME FOLDER
function [a0, a1] = linear_reg_fun(x,y)
  % VARIABLE DECLARATION AND CALCULATION
  n = length(x);
  sum_x = sum(x);
  sum_y = sum(y);
  sum_x2 = sum(x.^2);
  sum_xy = sum(x.*y);
  
  % y = a0 + a1*x
  % CALCULATE a0 & a1
  % n*a0 + sum_x*a1 = sum_y
  % sum_x*a0 + sum_x2*a1 = sum_xy
  A = [n sum_x sum_y; sum_x sum_x2 sum_xy];
  
  % SOLVE THE LINEAR SYSTEM OF EQUATIONS (GAUSS JORDAN ELIMINATION)
  solution = rref(A);
  a0 = solution(1,3);
  a1 = solution(2,3);
  
endfunction


