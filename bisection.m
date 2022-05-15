% The user enters a non-linear function
str = input('Give an equation in x: ','s')  ;
f = str2func(['@(x)',(str)]) ;


n = input("enter number of iterations: ");
a = input("enter the start: ");
b = input("enter the end: ");
x = a:0.01:b; % 0.01 is arbitrary
y = f(x);
a_i = find_i(x, a); % index of a
b_i = find_i(x, b); % index of b
mid = (a+b)/2;
mid_i = find_i(x, mid); % index of mid
out = 0; % Final output
for i = 1:1:n
    % if a == 0
    if y(a_i) == 0
        out = x(a_i);
    % if b == 0
    elseif y(b_i) == 0
        out = x(a_i);
    % if mid == 0
    elseif y(mid_i) == 0
        out = x(mid_i);

    elseif y(a_i)*y(mid_i) < 0
        a = x(a_i);
        b = x(mid_i);
        b_i = find_i(x, b);
        mid = (a+b)/2;
        mid_i = find_i(x, mid);
        out = mid;
    elseif y(b_i)*y(mid_i) < 0
        a = x(mid_i);
        a_i = find_i(x, a);
        b = x(b_i);
        mid = (a+b)/2;
        mid_i = find_i(x, mid);
        out = mid;
    else
        fprintf("There are no roots or multiple roots between %d and %d\n", a, b);
        break
    end
end

% Output
disp(out);

figure
plot(x,y)
grid


