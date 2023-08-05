function [rg,bitsg] = golombcode(r)
% This function calculated the golomb code according to the logic of
% splitting the input run-length sequence as the remainder and quotient
% part based on parameter k

%  Initialization
Ng = 1;
A = mean(r,2);              % Optimum value of A was found to be the estimate of the input run-lengths
Nmax = size(r,2);           % Increasing the value of Nmax gives more stable estimates for input.
                            % Smaller values of Nmax improves adaptability of the algorithm
rg = cell(size(r,2),1); 
keys = [];
r(2:end)= r(2:end)-1;

for i=1:size(r,2)
k = max(0,ceil(log2(A/(2*Ng))));
ru(1,i) = floor(r(i)/(2^k));
rc = mod(r(i),2^k);
rc = dec2bin(rc);
% Concatenating the unary code calculated form ru and rc in binary
rg{i,1} = [zeros(1,ru(1,i)) 1 str2num(rc(:))'];
% Calculating the number of bits to represent the coded sequence
arr(i) = size(rg{i,1},2);       
bitsg = sum(arr,2);
if(Ng==Nmax)
    A = floor(A/2);
    Ng = floor(Ng/2);
end
A = A + r(i);
Ng = Ng + 1;

end
end
