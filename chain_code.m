function [ feature_vector ] = chain_code( path,track,sector )
clc
track=3;
sector=8;
path='C:\Users\MRM\Documents\MATLAB\2.bmp';
img = imread(path);
img = 1-img;
img_size = size(img);
contour = bwboundaries(img);
contour = contour{1,1};
xc=0;
yc=0;
for i=1:img_size(1)
    for j=1:img_size(2)
        xc=xc+j*img(i,j);
        yc=yc+i*img(i,j);
    end
end

xc = xc/sum(sum(img));
yc = yc/sum(sum(img));
xc = round(xc);
yc = round(yc);

ydim = min(contour(:,1));
xdim = xc;
cvec = [yc xc];

contour_size = size(contour);
R = [];
for i=1:contour_size(1)
    point = contour(i,:);
    point = point-cvec;
    point = power(point,2);
    point = sum(point);
    point = sqrt(point);
    R = [R point];
end
R = max(R);
R = round(R);

f_matrix(8,1,sector*track)=0;
con_size = size(contour);
for i=1:(con_size(1)-1)
    ceta=0;
    dir=0;
    r=0;
    s=0;
    t=0;
    a = contour(i,:);% a is first pixel
    b = contour(i+1,:);% b is next pixel
    
    if b(1)==a(1) && b(2)>a(2)
        dir=1; 
    elseif b(1)<a(1) && b(2)>a(2)
        dir=2;
    elseif b(1)<a(1) && b(2)==a(2)
        dir=3;
    elseif b(1)<a(1) && b(2)<a(2)
        dir=4;
    elseif b(1)==a(1) && b(2)<a(2)
        dir=5;
    elseif b(1)>a(1) && b(2)<a(2)
        dir=6;
    elseif b(1)>a(1) && b(2)==a(2)
        dir=7;
    elseif b(1)>a(1) && b(2)>a(2)
        dir=8;
    end
    
    ceta = atand((a(1)-cvec(1))/(a(2)-cvec(2)));
    ceta = round(ceta);
    while ceta<0
        ceta = ceta + 360;
    end
    if a(1)==cvec(1) && a(2)==cvec(2)
        ceta = 0;
    end
    s = (ceta/360)*sector;
    s = floor(s);
    s = s+1;
   
    r = a-cvec;
    r = power(r,2);
    r = sum(r);
    r = sqrt(r);
    r = floor(r);

    t = (r/R)*track;
    t = ceil(t);
    if t==0
        t=1;
    end
   
    f_matrix(dir,1,((t-1)*sector)+s) = f_matrix(dir,1,((t-1)*sector)+s)+1;
end
f_v=[];
for i=1:sector*track
    if sum(f_matrix(:,:,i)) ~= 0
        f_matrix(:,:,i) = f_matrix(:,:,i)/sum(f_matrix(:,:,i));
    end
    f_v = [f_v ; f_matrix(:,:,i)];
end
f_v = f_v/sum(f_v);
feature_vector = f_v;
end