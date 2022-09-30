function output = myHE(input)

dimRow = size(input,1);
dimCol = size(input,2);
cdf_in = myCDF(input);

output = uint8(zeros(dimRow,dimCol));

% ToDo
L = 256;

for i = 1:dimRow
    for j = 1:dimCol
        beforeIntensity = input(i, j);
        afterIntensity = (L - 1).*cdf_in(beforeIntensity + 1, 1);
        output(i, j) = round(afterIntensity);
    end
end

end