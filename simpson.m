%syms x
%y = x^2 - 4*x -7;
a = input("Enter the start of integration: ");
b = input("Enter the end of integration: ");
n = input("Enter the number of segments: ");
I = 0;
if n < 2 | mod(n, 1) ~= 0
    n = input("Invalid input, Enter an integer greater than 1: ");
elseif n == 2
    h = (b-a)/2;
    I = (h/3)*((a^2-4*a-7) + 4*((a+h)^2-4*(a+h)-7) + (b^2-4*b-7));
    %disp(I)
elseif n > 2 && mod(n,2) == 1
    n = input("Number of segments must be even: ");
elseif n > 2
    h = (b-a)/n;
    pts = a:h:b;
    for j = 0:1:n
        if j == 0
            I = I+(a^2-4*a-7);
        elseif j == n
            I == I+(b^2-4*b-7);
        elseif mod(j,2) == 1
            I = I + 4*((pts(j))^2-4*(pts(j))-7);
        elseif mod(j, 2) == 0
            I = I + 2*((pts(j))^2-4*(pts(j))-7);
        endif
    endfor
    I = I*(h/3)
end
disp(I);
