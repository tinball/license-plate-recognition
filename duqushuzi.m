function shuzi=duqushuzi(s0,s1,s2,s3,s4,s5,s6,s7,s8,s9)
%=======================²ÊÉ«×ª»Ò¶È============
shuzi(:,:,1)   =imresize(im2bw(rgb2gray(s0),graythresh(rgb2gray(s0))),[110 55],'bilinear');
shuzi(:,:,2)   =imresize(im2bw(rgb2gray(s1),graythresh(rgb2gray(s1))),[110 55],'bilinear');
shuzi(:,:,3)   =imresize(im2bw(rgb2gray(s2),graythresh(rgb2gray(s2))),[110 55],'bilinear');
shuzi(:,:,4)   =imresize(im2bw(rgb2gray(s3),graythresh(rgb2gray(s3))),[110 55],'bilinear');
shuzi(:,:,5)   =imresize(im2bw(rgb2gray(s4),graythresh(rgb2gray(s4))),[110 55],'bilinear');
shuzi(:,:,6)   =imresize(im2bw(rgb2gray(s5),graythresh(rgb2gray(s5))),[110 55],'bilinear');
shuzi(:,:,7)   =imresize(im2bw(rgb2gray(s6),graythresh(rgb2gray(s6))),[110 55],'bilinear');
shuzi(:,:,8)   =imresize(im2bw(rgb2gray(s7),graythresh(rgb2gray(s7))),[110 55],'bilinear');
shuzi(:,:,9)   =imresize(im2bw(rgb2gray(s8),graythresh(rgb2gray(s8))),[110 55],'bilinear');
shuzi(:,:,10)  =imresize(im2bw(rgb2gray(s9),graythresh(rgb2gray(s9))),[110 55],'bilinear');

