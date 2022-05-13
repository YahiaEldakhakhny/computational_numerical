syms x
y = x^2 - 4*x -7;
a = input("Enter the start of integration: ");
b = input("Enter the end of integration: ");
n = input("Enter the number of segments: ");
if n < 2
    n = input("Invalid input, Enter an integer greater than 1: ");
elseif n == 2
    h = (b-a)/2;
    I = (h/3)*(subs(y,x,a) + 4*subs(y,x,a+h) + subs(y,x,b))
end