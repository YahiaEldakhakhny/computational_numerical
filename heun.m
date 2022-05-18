% Euler's Method
% Initial conditions and setup

str = input('Give an equation in x,y: ','s')  ;
   % the user types in, for instance 2*x^2-3*x+4

f = str2func(['@(x,y)',(str)]) ;

h = input("enter your step size here ");  % step size
a=input("enter the starting value of x here ");
b=input("enter the ending value of x here ");
x = a:h:b;  % the range of x

y = zeros(size(x));  % allocate the result y
y_pre = zeros(size(x));
dy = zeros(size(x));

y(1) = input("enter the starting value of y here ");  % the initial y value
n = numel(y);  % the number of y values

% The loop to solve the DE
for i=1:n-1
    dy(i)=f(x(i),y(i));
    y_pre(i) = y(i) + h *dy(i) ;
    avr=(f(x(i+1), y_pre(i)) +dy(i)) /2;
    y(i+1) = y(i) + h *avr ;

end


figure
scatter(x,y);
plot(x,y);

for i=1:n
    txt=['y = ',num2str(y(i)),' at x = ',num2str(x(i)),'.'];
   disp(txt);
end

