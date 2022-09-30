function output = myAHE(input, numtiles)

dimRow = size(input,1);
dimCol = size(input,2);

nBlockRow = numtiles(1, 1);
nBlockCol = numtiles(1, 2);

intervalRow = round(dimRow / nBlockRow);
intervalCol = round(dimCol / nBlockCol);

L = 256;

output = uint8(zeros(dimRow,dimCol));

% ToDo
cdfPerTile = zeros(nBlockRow, nBlockCol, 256);

for i = 1:nBlockRow
    for j = 1:nBlockCol
        startX = intervalRow.*(i - 1) + 1;
        endX = min(intervalRow.*i, dimRow);

        startY = intervalCol.*(j - 1) + 1;
        endY = min(intervalCol.*j, dimCol); 

        tmpMatrix = input(startX:endX, startY:endY);
        tmpCDF = myCDF(tmpMatrix);

        for k = 1:L
            cdfPerTile(i, j, k) = tmpCDF(k, 1);
        end

    end
end

for i = 1:dimRow
    for j = 1:dimCol
        [top, left] = findLT(i, j, intervalRow, intervalCol, nBlockRow, nBlockCol);
        center = zeros(4, 2);
        count = 1;
        
        if (top > 0 && top <= nBlockRow && left > 0 && left <= nBlockCol)
            center(count, 1) = top;
            center(count, 2) = left;
            count = count + 1;
        end
        % Q11(count == 2)
        if (top + 1 > 0 && top + 1 <= nBlockRow && left > 0 && left <= nBlockCol)
            center(count, 1) = top + 1;
            center(count, 2) = left;
            count = count + 1;
        end
        % Q22(count == 3)
        if (top > 0 && top <= nBlockRow && left + 1 > 0 && left + 1 <= nBlockCol)
            center(count, 1) = top;
            center(count, 2) = left + 1;
            count = count + 1;
        end
        if (top + 1 > 0 && top + 1 <= nBlockRow && left + 1 > 0 && left + 1 <= nBlockCol)
            center(count, 1) = top + 1;
            center(count, 2) = left + 1;
            count = count + 1;
        end

        % corner
        if (count == 2)
            result = round((L - 1).*cdfPerTile(center(1, 1), center(1, 2), input(i, j) + 1));
            output(i, j) = round(result);
        % boundary
        elseif (count == 3)
            i1 = round((L - 1).*cdfPerTile(center(1, 1), center(1, 2), input(i, j) + 1));
            i2 = round((L - 1).*cdfPerTile(center(2, 1), center(2, 2), input(i, j) + 1));
            result = 0;
            if (center(1, 2) == center(2, 2))
                row1 = intervalRow / 2 + (center(1, 1) - 1).*intervalRow;
                row2 = intervalRow / 2 + (center(2, 1) - 1).*intervalRow;
                result = i1 * abs(i - row2) / intervalRow + i2 * abs(i - row1) / intervalRow;
            else
                col1 = intervalCol / 2 + (center(1, 2) - 1).*intervalCol;
                col2 = intervalCol / 2 + (center(2, 2) - 1).*intervalCol;
                result = i1 * abs(j - col2) / intervalCol + i2 * abs(j - col1) / intervalCol;
            end
            
            output(i, j) = round(result);
        else
            row1 = intervalRow / 2 + (center(2, 1) - 1).*intervalRow;
            col1 = intervalCol / 2 + (center(2, 2) - 1).*intervalCol;
            row2 = intervalRow / 2 + (center(3, 1) - 1).*intervalRow;
            col2 = intervalCol / 2 + (center(3, 2) - 1).*intervalCol;
            i12 = round((L - 1).*cdfPerTile(center(1, 1), center(1, 2), input(i, j) + 1));
            i11 = round((L - 1).*cdfPerTile(center(2, 1), center(2, 2), input(i, j) + 1));
            i22 = round((L - 1).*cdfPerTile(center(3, 1), center(3, 2), input(i, j) + 1));
            i21 = round((L - 1).*cdfPerTile(center(4, 1), center(4, 2), input(i, j) + 1));

            result = (row2 - i).*(col2 - j).*i11 / (row2 - row1) / (col2 - col1) + (i - row1).*(col2 - j).*i21 / (row2 - row1) / (col2 - col1) + (row2 - i).*(j - col1).*i12 / (row2 - row1) / (col2 - col1) + (i - row1).*(j - col1).*i22 / (row2 - row1) / (col2 - col1);
            output(i, j) = round(result);
        end
    end
end

end


function [top, left] = findLT(row, col, intervalRow, intervalCol, nBlockRow, nBlockCol)

startX = round(intervalRow / 2);
startY = round(intervalCol / 2);

top = nBlockRow;
left = nBlockCol;

for i = 1:nBlockRow
    if (row <= startX + intervalRow.*(i - 1)) 
        top = i - 1;
        break
    end
end

for i = 1:nBlockCol
    if (col <= startY + intervalCol.*(i - 1)) 
        left = i - 1;
        break
    end
end

end