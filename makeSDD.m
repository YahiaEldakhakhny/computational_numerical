% Function to rearrange a matrix to make it strictly diagonally dominant 
function [A, i] = makeSDD(x)
    A = [];
       i=1;
    [r,c] = size(x);
    if r ~= c
        A = -1;
        error('A is not square');
    end
    
    [maxrow,maxind] = max(abs(x),[],2); % maxrow = values of max elements of each row, maxind is their indicies
 
   
    if all(maxrow > (sum(abs(x),2) - maxrow)) && isequal(sort(maxind),(1:numel(maxind))')
A(maxind,:) = x;
%         for k= maxind'
%             A(i)=x(k);
%             i=i+1;
%         end
        
    end

end