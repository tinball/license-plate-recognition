function qingxiejiao=rando_bianhuan(I)
I=edge(I);%figure,imshow(I);
theta = 1:180;
[R,xp] = radon(I,theta);
%figure,imagesc(theta,xp,R);colormap(hot);%title('R_{\theta} (X\prime)')%%imshow(theta,xp,R,[],'n')
[I,J] = find(R>=max(max(R)));%J��¼����б��
qingxiejiao=90-J;
%ֱ��λ��
% xlabel('\theta (degrees)');ylabel('X\prime');
% % colormap(hot)%     colorbar  IMAGE(C) displays matrix C as an image.
% title('R_{\theta} (X\prime)');
% colorbar;