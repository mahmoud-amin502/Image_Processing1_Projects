function [ output_args ] = Testing_PCA ( input_args )

for i=1:4
    img = imread('cameraman.tif');
    img = PCA(20*i,10,10,img);
    subplot(2,2,i);
    imshow(img);
end

end

