function [ ] = MDC_VS_MSSE( )
clc
path1='C:\Users\Ma7mood\Desktop\test data';
path2='.bmp';
track=4;
sector=16;
sympol=0;
path=[];
msse_x=[];
mdc_x=[];
msse_count = 0;
mdc_count = 0;
while(sympol<=9)
    path = strcat(path1,92,sympol+48,path2);
    msse_x = Testing_MSSE(path);
    mdc_x = test(path);
    if(msse_x == sympol)
        msse_count = msse_count+1;
    end
    if(mdc_x == sympol)
       mdc_count = mdc_count+1;
    end
    if(sympol == 9)
        break;
    end
    sympol = sympol+1;
end
msse_count
mdc_count
end