% Function to rearrange a matrix to make it strictly diagonally dominant 
function A = makeSDD(x)
A = x;    
[r,c] = size(x);
    if r ~= c
        error('A is not square');
    end
    
    % maxrow = values of max elements of each row, maxind is their indicies
    [maxrow,maxind] = max(abs(x),[],2); 
 
    % make sure the matrix can be turned into a SDD matrix
    if all(maxrow > (sum(abs(x),2) - maxrow)) && isequal(sort(maxind),(1:numel(maxind))')
        for i = 1:1:length(maxind)
            A(i, :) = x(maxind(i), :);
        end
    else
        disp('Sorry, but this matrix can never be made to be diagonally dominant')
        A =x;
    end

end