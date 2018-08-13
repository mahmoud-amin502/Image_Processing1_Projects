function [ ws ] = MSSE( )
clc
f_t=[];
load('f_t.mat','f_t');
f_v_size=size(f_t);
f_v_size=f_v_size(2);
ws = [];
for i=1:10
    row = [];
    z = [];
    w = [];
    b = ones(100,1);
    for j=1:100
        row = f_t(j,:);
        row(:,513) = 1; 
        if ~(j>=((i-1)*10+1)&&j<=i*10)
            row = row*-1;
        end
        z = [z;row];
    end
    w = pinv(z'*z)*z'*b;
    ws = [ws w];
end
save('desc_fun.mat','ws');
end 