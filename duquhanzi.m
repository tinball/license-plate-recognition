function hanzi=duquhanzi(cpgui,cpguizhou,cpjing,cpsu,cpyue)
hanzi(:,:,1)  =imresize(im2bw(cpgui,graythresh(rgb2gray(cpgui))),[110 55],'bilinear');
hanzi(:,:,2)  =imresize(im2bw(cpguizhou,graythresh(rgb2gray(cpguizhou))),[110 55],'bilinear');
hanzi(:,:,3)  =imresize(im2bw(cpjing,graythresh(rgb2gray(cpjing))),[110 55],'bilinear');
hanzi(:,:,4)  =imresize(im2bw(cpsu,graythresh(rgb2gray(cpsu))),[110 55],'bilinear');
hanzi(:,:,5)  =imresize(im2bw(cpyue,graythresh(rgb2gray(cpyue))),[110 55],'bilinear');