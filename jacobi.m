% prompt the user to enter the coefficient matrix
A = input("enter the augmented coefficient matrix: ");

% Number of rows in A (number of equations in the system)
r = size(A,1);

% Number of columns in A (number of variables in the system)
c = size(A, 2);

% make sure A is strictly diagonally dominant (SDD)
% will return A1 = all zeros if A cannot be converted to SDD
A1 = makeSDD(A);
if A1 == zeros(r,c)
    % warn the user that the solution may not converge
    res = input("This matrix cannot be strictly diagonally dominat do you want to continue anyway [Y/n]: ");
    if res ~= 'n'
       x = compute_jacobi(A1)
    end
else
    x = compute_jacobi(A1)
end






