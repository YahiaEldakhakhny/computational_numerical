function index = find_i(arr, val)% function to find a specific value in an array
    d = zeros(1, length(arr));
    
    for i = 1:1:length(arr)
        if arr(i) == val
            index = i;
            
        elseif (arr(i) ~= val ) && ( i ~= length(arr))
            d(i) = abs(val-arr(i));
            
        elseif i == length(arr)
            index = -1;
        end %end of if
    end %end of for loop
    
    d(end) = abs(val-arr(end));
    
    % if val is not in arr then get the index of the closest element
    if index == -1
        m = d(1);
        m_i = 1;
        for j = 1:1:length(d)
            if d(j) < m
                m = d(j);
                m_i = j;
            end %end if
        end %end of for loop
        index = m_i;
    end %end of if
    
end %end of function