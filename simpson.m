% the user types in, for instance 2*x^2-3*x+4
str = input('Give an equation in x: ','s')  ;

% y = f(x) ;
f = str2func(['@(x)',(str)]) ;

% Take input from user
a = input("Enter the start of integration: ");
b = input("Enter the end of integration: ");
n = input("Enter the number of segments: ");

% I is the result of the integration
I = 0;

% Check that the user entered a valid n
if n < 2 | mod(n, 1) ~= 0
    n = input("Invalid input, Enter an integer greater than 1: ");

% If n == 2 the this is normal simpson
elseif n == 2
    h = (b-a)/2;
    x = a:h:b;
    y = f(x);
    I = (h/3)*(y(1) + 4*y(2) + y(3));
% If n > 2 it must be even
elseif n > 2 && mod(n,2) == 1
    n = input("Number of segments must be even: ");
% If n > 2 and is even then it is composit simpson
elseif n > 2
    h = (b-a)/n;
    x = a:h:b;
    y = f(x);
    % j starts at 1 so I shifted the rule by 1
    for j = 1:1:n
        if j == 1
            I = I+y(j);
        elseif j == n
            I == I+y(n+1);
        % odd indicies are multiplied by 2 because I started j at 1
        elseif mod(j,2) == 1
            I = I + 2*y(j);
        % even indicies are multiplied by 4 because I started j at 1
        elseif mod(j, 2) == 0
            I = I + 4*y(j);
        endif
    endfor
    I = I*(h/3);
end
disp(I);
