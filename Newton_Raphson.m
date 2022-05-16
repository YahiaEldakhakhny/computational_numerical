
%Entering the function
y = 0;
syms x
str = input('Give an equation in x: ','s')  ;
f = str2func(['@(x)',(str)]) ;
y = f(x);

y
fplot(y,[-6 6]);
grid on
grid minor
%Test Function:  y = x^2 - 4*x -7; 
%Roots = 5.317, -1.317
x0 = input ('Enter the intial guess:');
m = input ('Enter the number of iterations:');
x_n = zeros (1,m+1); x_n(1) = x0;
y_dash = diff(y) % Differentaition

for i = 2:m+1
  x_n(i) = x_n(i-1) - ( subs (y,x,x_n(i-1))  / subs (y_dash,x,x_n(i-1)) )
end

x_n(m+1)
%{
y_dash = diff(y);
y_dash_dash = diff(y_dash);
x0 = 5;
x1 = x0 - ( subs(y,x,x0) / subs(y_dash,x,x0) )
x2 = x1 - ( subs(y_dash,x,x0) / subs(y_dash_dash,x,x0) )

%}
%{
figure
plot (x, y);
hold on;
plot (x, y_dash);
grid on;
%}
