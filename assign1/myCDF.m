function output = myCDF(image)

output=zeros(256,1);

% todo
prob = zeros(256, 1);
total = size(image, 1).*size(image, 2);

for i = 0:255
    count = sum(image(:) == i);
    prob(i + 1, 1) = count / total;
end

tmp = 0;

for i = 0:255
    tmp = tmp + prob(i + 1, 1);
    output(i + 1, 1) = tmp;
end

end