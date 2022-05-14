
%Entering the function
n = input ('The order = ');
Z = ones(1, n+1);    % A row vector of length (n+1) shall carry the coefficients of each term
y = 0;
syms x

 for j = length(Z):-1:1
                Z(j) = input (['Coefficent for x^' num2str(j-1) '= ']); 
                %At each loop, the user enters the coeff of each term, starting with the highest power.
                temp = Z(j).*x^(j-1);
                y = y + temp;
 end
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
