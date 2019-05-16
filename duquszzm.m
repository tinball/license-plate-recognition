function shuzizimu = duquszzm(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,...
                              s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,...
                              s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,...
                              s31,s32,s33,s34)
%0-9            
%10-15 ABCDE 6-10FGHJK 16-20 LMNPQ 21-25 RSTUV 26-30 WXYZ
shuzizimu(:,:,1)   =imresize(im2bw(s1, graythresh(rgb2gray(s1))), [110 55],'bilinear');
shuzizimu(:,:,2)   =imresize(im2bw(s2, graythresh(rgb2gray(s2))), [110 55],'bilinear');
shuzizimu(:,:,3)   =imresize(im2bw(s3, graythresh(rgb2gray(s3))), [110 55],'bilinear');
shuzizimu(:,:,4)   =imresize(im2bw(s4, graythresh(rgb2gray(s4))), [110 55],'bilinear');
shuzizimu(:,:,5)   =imresize(im2bw(s5, graythresh(rgb2gray(s5))), [110 55],'bilinear');
shuzizimu(:,:,6)   =imresize(im2bw(s6, graythresh(rgb2gray(s6))), [110 55],'bilinear');
shuzizimu(:,:,7)   =imresize(im2bw(s7, graythresh(rgb2gray(s7))), [110 55],'bilinear');
shuzizimu(:,:,8)   =imresize(im2bw(s8, graythresh(rgb2gray(s8))), [110 55],'bilinear');
shuzizimu(:,:,9)   =imresize(im2bw(s9, graythresh(rgb2gray(s9))), [110 55],'bilinear');
shuzizimu(:,:,10)  =imresize(im2bw(s10,graythresh(rgb2gray(s10))),[110 55],'bilinear');
shuzizimu(:,:,11)  =imresize(im2bw(s11,graythresh(rgb2gray(s11))),[110 55],'bilinear');
shuzizimu(:,:,12)  =imresize(im2bw(s12,graythresh(rgb2gray(s12))),[110 55],'bilinear');
shuzizimu(:,:,13)  =imresize(im2bw(s13,graythresh(rgb2gray(s13))),[110 55],'bilinear');
shuzizimu(:,:,14)  =imresize(im2bw(s14,graythresh(rgb2gray(s14))),[110 55],'bilinear');
shuzizimu(:,:,15)  =imresize(im2bw(s15,graythresh(rgb2gray(s15))),[110 55],'bilinear');
shuzizimu(:,:,16)  =imresize(im2bw(s16,graythresh(rgb2gray(s16))),[110 55],'bilinear');
shuzizimu(:,:,17)  =imresize(im2bw(s17,graythresh(rgb2gray(s17))),[110 55],'bilinear');
shuzizimu(:,:,18)  =imresize(im2bw(s18,graythresh(rgb2gray(s18))),[110 55],'bilinear');
shuzizimu(:,:,19)  =imresize(im2bw(s19,graythresh(rgb2gray(s19))),[110 55],'bilinear');
shuzizimu(:,:,20)  =imresize(im2bw(s20,graythresh(rgb2gray(s20))),[110 55],'bilinear');
shuzizimu(:,:,21)  =imresize(im2bw(s21,graythresh(rgb2gray(s21))),[110 55],'bilinear');
shuzizimu(:,:,22)  =imresize(im2bw(s22,graythresh(rgb2gray(s22))),[110 55],'bilinear');
shuzizimu(:,:,23)  =imresize(im2bw(s23,graythresh(rgb2gray(s23))),[110 55],'bilinear');
shuzizimu(:,:,24)  =imresize(im2bw(s24,graythresh(rgb2gray(s24))),[110 55],'bilinear');
shuzizimu(:,:,25)  =imresize(im2bw(s25,graythresh(rgb2gray(s25))),[110 55],'bilinear');
shuzizimu(:,:,26)  =imresize(im2bw(s26,graythresh(rgb2gray(s26))),[110 55],'bilinear');
shuzizimu(:,:,27)  =imresize(im2bw(s27,graythresh(rgb2gray(s27))),[110 55],'bilinear');
shuzizimu(:,:,28)  =imresize(im2bw(s28,graythresh(rgb2gray(s28))),[110 55],'bilinear');
shuzizimu(:,:,29)  =imresize(im2bw(s29,graythresh(rgb2gray(s29))),[110 55],'bilinear');
shuzizimu(:,:,30)  =imresize(im2bw(s30,graythresh(rgb2gray(s30))),[110 55],'bilinear');
shuzizimu(:,:,31)  =imresize(im2bw(s31,graythresh(rgb2gray(s31))),[110 55],'bilinear');
shuzizimu(:,:,32)  =imresize(im2bw(s32,graythresh(rgb2gray(s32))),[110 55],'bilinear');
shuzizimu(:,:,33)  =imresize(im2bw(s33,graythresh(rgb2gray(s33))),[110 55],'bilinear');
shuzizimu(:,:,34)  =imresize(im2bw(s34,graythresh(rgb2gray(s34))),[110 55],'bilinear');
