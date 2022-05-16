a = input("Enter the first value:\n");
b = input("Enter the last value:\n");
n = input ('Enter the number of sections :\n');
x = linspace(a,b,n+1);

str = input('Give an equation in x: ','s') ;
f = str2func(['@(x)',(str)]) ;
y = f(x);

delta = ( x(length((x))-x(1)) )/n
Area = 0;
Area = y(1) + y(length(x)) %Adding the the first and last values f(a), f(b)
%Adding twice the middle heights to the area.
for i= 2:length(x)-1
    Area = Area + 2*y(i)
end
Area = Area*delta/2 %The area is multiplied by the step size divided by 2