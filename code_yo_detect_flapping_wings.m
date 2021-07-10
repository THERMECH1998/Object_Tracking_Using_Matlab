%% Code Developed By Ramayana 
close all
clear
clc
%% Set up video reader and player
videoFReader = vision.VideoFileReader('Flapping.mp4',...
    'VideoOutputDataType','double');
vidPlayer = vision.DeployableVideoPlayer;


%% Convert video into frames and into black and white
while ~isDone(videoFReader)
    im = step(videoFReader);
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

end