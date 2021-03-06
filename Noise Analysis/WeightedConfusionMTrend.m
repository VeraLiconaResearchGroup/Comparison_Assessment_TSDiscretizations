function f = WeightedConfusionMTrend(original, ddata)
% mat1, mat2 are matrix to be compared; 
% each time series is a 1*m vector;
m = size(original, 2);
n = size(original, 1);
for i = 1:m-1
    vec1(:,i) = original(:,i+1) - original(:,i);
    vec2(:,i) = ddata(:,i+1) - ddata(:,i);
end

nouvear1 = sign(vec1);
nouvear2 = sign(vec2);

TP = 0; 
FP = 0; 
TN = 0; 
FN = 0; 

for i = 1:m-1
    for j = 1:n
        if nouvear1(j,i) == 1 % the original data shows an increase;
            if nouvear2(j,i) > 0.5 % the discretized data also show an increase
                TP = TP + abs(vec1(j,i));
            else 
                if nouvear2(j,i) < 0.5
                    FN = FN + abs(vec1(j,i));
                end
            end
        else
            if nouvear1(j,i) == -1
                if nouvear2(j,i) > -0.5
                    FP = FP + abs(vec1(j,i));
                else
                    if nouvear2(j,i) < -0.5
                        TN = TN + abs(vec1(j,i));
                    end
                end
            end
        end
    end
end

ppv = TP/(TP + FP); % positive predicted value
sensitivity = TP/(TP + FN); 

accuracy = (TP+TN)/(TP+TN+FP+FN);

f = [TP, FN, FP, TN, ppv, sensitivity, accuracy];

