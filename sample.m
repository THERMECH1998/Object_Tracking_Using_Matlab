close all;
clc;
clear all;
videoFReader = vision.VideoFileReader('Video_Trim.mp4',...
    'VideoOutputDataType','double');
vidPlayer = vision.DeployableVideoPlayer;

%%im = imread('Screenshot (619).png');
%%imshow(im);

idx = 1;
while ~isDone(videoFReader)
    im= step(videoFReader);
    
    idx = idx + 1;
imgray = rgb2gray(im);
figure(2);
imshow(imgray);
imbin = imbinarize(imgray);
figure(3);
imshow(imbin);
im = edge(imbin, 'prewitt');
figure(5);
imshow(im);
im = imdilate(im, strel('diamond', 2));
im = imfill(im, 'holes');
im = imerode(im, strel('diamond', 10));
figure(6);
imshow(im);
Iprops=regionprops(im,'BoundingBox','Area', 'Image','Centroid');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    


im = imcrop(imbin, boundingBox);
im = bwareaopen(~im, 500);
figure(7)
imshow(im);
s  = regionprops(im, 'centroid');
centroids(idx,:) = cat(1, s.Centroid);
end
