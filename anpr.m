function [X,final] = anpr(f)
%pkg load image
%.................................
%f=imread('sam14.jpg');
%f=imresize(f,[400 NaN]);                   %%image loading unit
%figure(1)
%imshow(f);
g=rgb2gray(f);
g=medfilt2(g,[3 3]);
%figure(20)
%imshow(g)


%**********************************
conc=strel('disk',1,0);
gi=imdilate(g,conc);
ge=imerode(g,conc);            %%%% morphological image processing
gdiff=imsubtract(gi,ge);
gdiff=mat2gray(gdiff);
gdiff=conv2(gdiff,[1 1;1 1]);
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],.1);
B=logical(gdiff);
[a1 b1]=size(B);
%figure(2)
%imshow(B)
erh=imerode(B,strel('line',90,0));
er=imerode(erh,strel('line',100,0));
%figure(3)
%imshow(er)
out1=imsubtract(B,er);
F=bwfill(out1,'holes',4);      %%%filling the object
H=bwmorph(F,'thin',1);
H=imerode(H,strel('line',5,90));
%figure(4)
%imshow(H);
final=bwareaopen(H,floor((a1/15)*(b1/15))); 
%figure(5)
%imshow(final);
label=bwlabel(final);
max(max(label))
im1=(label==2);
%figure(6)
%imshow(im1);

%load('imagedata.mat');
%s=size(vector,1);
s=1;

for j=1:max(max(label))
[row, col]=find(label==j);
len=max(row)-min(row)+2;
breadth=max(col)-min(col)+2;
target=(zeros([len breadth]));
sy=min(col)-1;
sx=min(row)-1;
for i=1:size(row,1)
   x=row(i,1)-sx;
   y=col(i,1)-sy;
   target(x,y)=final(row(i,1),col(i,1));
end
mytitle=strcat('objectNumber',num2str(j));
saven=strcat(mytitle,'.jpg');
%figure;imshow(target);title(mytitle);
target=imresize(target,[38 20]);
target=im2bw(target,0.5);
imwrite(target,saven);
X(s,:)=target(:)';
s=s+1;
%mat = reshape(target,38,20);      % reshaping the matrix
%figure(i)
%imshow(mat);
end

end











