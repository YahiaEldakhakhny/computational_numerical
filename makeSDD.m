% Function to rearrange a matrix to make it strictly diagonally dominant 
function A = makeSDD(x)
A = x;
% x1 is just the coefficient part of x, x1 is x when it is not augmented
x1 = x((1:end),(1:end-1));
[r,c] = size(x);
    if (r +1) ~= c
        A = 0;
    end
    
    % maxrow = values of max elements of each row, maxind is their indicies
    [maxrow,maxind] = max(abs(x1),[],2); 
 
    % make sure the matrix can be turned into a SDD matrix
    if all(maxrow > (sum(abs(x1),2) - maxrow)) && isequal(sort(maxind),(1:numel(maxind))')
        for i = 1:1:length(maxind)
            A(i, :) = x(maxind(i), :);
        end
    else
        disp('Sorry, but this matrix can never be made to be diagonally dominant')
        A =0;
    end

end