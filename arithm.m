function [y] = arithm(x,Ptr)
% Arithmetic encoding the input sequence x according to the probability Ptr
% Initialization
C = 0; P = 8; N = 22;
A = 2^N;
r = -1; b = 0;

y = [];

for n = 1:length(x)
    % Calculate the po value based on the transition probability matrix Ptr
    % for a markov process x
    if(n==1)
        po = floor((2^P)*Ptr(1,1));
    else
        if(x(n-1)==0)
            po = floor((2^P)*Ptr(1,1));
        else
            po = floor((2^P)*Ptr(1,2));
        end
    end
    T = A*po;
    if x(n)==1
        C = C + T;
        T = bitshift(A,P) - T;
    end

    if(C >= 2^(N+P))
        C = bitand(C,2^(N+P)-1);
        % propagate carry
        y = [y 1];
        if(r>0)
            y = [y zeros(1,r-1)];
            r=0;
        else
            r=-1;
        end
    end

    while T<2^(N+P-1)
        % renormalize once
        b=b+1;
        T=bitshift(T,1);
        C=bitshift(C,1);
        if(C >= 2^(N+P))
            C = bitand(C,2^(N+P)-1);
            % overflow of C
            if(r<0)
                y = [y 1];
            else
                r=r+1;
            end
        else
            % no overflow of C
            if(r>=0)
                y = [y 0];
                y = [y ones(1,r)];
            end
            r=0;
        end
    end
    A = floor(T/(2^P));
end

if(r>=0)
    y = [y 0];
    y = [y ones(1,r)];
end
Cb = dec2bin(C);
if(length(C)<= N+P)
    y = [y str2num(Cb(:))'];
else
    Cb = Cb(1:N+P);
    y = [y str2num(Cb(:))'];
end

end