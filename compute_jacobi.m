function x =  compute_jacobi(A)
        x_init = input("Enter the initial guess: ");
        n = input("Enter number of iterations: ");
        x_new = x_init;
        % coefficients of the first equation
        a1 = A(1, 1:end-1);
        % coefficients of the second equation
        a2 = A(2, 1:end-1);
        % coefficients of the third equation
        a3 = A(3, 1:end-1);
        % free terms (last column in A)
        b = A(:, end);
        for i = 1:1:n
            % store the results of the previous iteration to use it in the
            % new one
            x_init = x_new;

            % calculate new x using the previous values
            x_new(1) = (b(1)-a1(2)*x_init(2)-a1(3)*x_init(3))/a1(1);
            x_new(2) = (b(2)-a2(1)*x_init(1)-a2(3)*x_init(3))/a2(2);
            x_new(3) = (b(3)-a3(1)*x_init(1)-a3(2)*x_init(2))/a3(3);
        end
        x = x_new;
    end
