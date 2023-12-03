function out = isin(array, element)
    arr_ismember = ismembertol(array,element);
    out = sum(arr_ismember) > 0;
end

   