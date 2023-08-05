function [y,bits,arr] = runlength(x)
% Run-length coder function with input as markov stream and output encoded
% sequence and optimum bits to represent run-length codes. The coded
% sequence y has the first bit received on the first index followed by
% run-length values

y = [x(1)];
arr(1) = ceil(log2(y(1)));
count = 1;
for i=1:length(x)-1
    if(x(i)==x(i+1))
        count = count + 1;
    else            
        y = [y,count,];
       
        count=1;
    end
end
y = [y,count];
% Calculating the total bits required to represent the coded sequence
arr = max(1,ceil(log2(y)));       
bits = sum(arr,2);
end