function [ ] = Tisting_Neural_net( )
clc
net = [];
load('net.mat','net');
path1='C:\Users\Ma7mood\Desktop\test data';
path2='.bmp';
sympol=0;
res=0;
full_res=[];
while(sympol<=9)
    path = strcat(path1,92,sympol+48,path2);
    x = chain_code(path,4,16);
    res = net(x);
    max=0;
    pos=-1;
    for i=1:10
        if(res(i)>max)
            max=res(i);
            pos=i;
        end
    end
    full_res = [full_res pos-1];
    if(sympol == 9)
        break;
    end
    sympol = sympol+1;
end
display(full_res);
end