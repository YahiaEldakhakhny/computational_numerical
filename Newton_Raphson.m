
syms x
y = x^2 - 4*x -7;
y_dash = diff(y);
x0 = 5;
x1 = x0 - ( subs(y,x,x0) / subs(y_dash,x,x0) )


%{
figure
plot (x, y);
hold on;
plot (x, y_dash);
grid on;
%}
