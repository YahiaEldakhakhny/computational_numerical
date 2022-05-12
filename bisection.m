n = input("enter number of iterations: ");
a = input("enter the start: ");
b = input("enter the end: ");
x = linspace(a, b, 1000);
y = x.^2-1;
a_i = find_i(x, a);
b_i = find_i(x, b);
mid = (a+b)/2;
mid_i = find_i(x, mid);
out = 0;
for i = 1:1:n
    if y(a_i) == 0
        out = x(a_i);
        
    elseif y(b_i) == 0
        out = x(a_i);
    
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
        fprintf("There are no roots between %d and %d\n", a, b);
        break
    end
end

figure
plot(x,y)
grid
hold on

xline(out)
hold off