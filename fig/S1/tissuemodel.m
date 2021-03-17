   clc;clear;close all;
% tube size:
l=1000;d=50;
%penetration position
x0=800;y0=1000;z0=5;
%penetration angle
theta=90;phi=90;
% crossection rotation angle
crossectR = 0; 
% tissue size
XX=1000;
YY=1000;
ZZ=10;
NUM=ZZ;

% load the picture to build tissue voxel model
Hstr1 = 'C:\Users\Qiang\Desktop\project1\H\';
Estr1 = 'C:\Users\Qiang\Desktop\project1\E\';
Originstr0 = 'C:\Users\Qiang\Desktop\project1\origin\';
Originstr1 = 'C:\Users\Qiang\Desktop\project1\originlabel\';
Originstr2 = 'C:\Users\Qiang\Desktop\project1\originlabelrgb\';
Hpicstr= dir(fullfile('C:\Users\Qiang\Desktop\project1\H\*.png'));%
Epicstr= dir(fullfile('C:\Users\Qiang\Desktop\project1\E\*.png'));%
OOriginstr= dir(fullfile('C:\Users\Qiang\Desktop\project1\origin\*.png'));%
num = length(Hpicstr);

Hpicgather(1:XX,1:YY,1:ZZ) = uint8(zeros(XX,YY,ZZ)); 
Epicgather(1:XX,1:YY,1:ZZ) = uint8(zeros(XX,YY,ZZ));
opicgather(1:XX,1:YY,1:ZZ) = uint8(zeros(XX,YY,ZZ));
orgbpicgather(1:XX,1:YY,1:3,1:ZZ) = uint8(zeros(XX,YY,3,ZZ));
xxpicgather(1:XX,1:YY,1:3,1:ZZ) = uint8(zeros(XX,YY,3,ZZ));

%RGB value of the pictures VR,VG,VB
VR(1:XX,1:YY,1:NUM) = double(zeros(XX,YY,NUM));
VG(1:XX,1:YY,1:NUM) = double(zeros(XX,YY,NUM));
VB(1:XX,1:YY,1:NUM) = double(zeros(XX,YY,NUM));

for k=1:ZZ  
% store the labeled pixels
labelpic=Originstr1+string(k)+'.png';
labelpic = imread(labelpic);
labelpic=double(labelpic);
labelpic= imrotate(labelpic,270);
opicgather(1:XX,1:YY,k)=labelpic;

%load origin picture to build tissue
Oname=Originstr0+string(k)+'.png';
Oname = imread(Oname);
Oname=double(Oname);

%load labeled origin picture to build tissue
Oname1=Originstr2+string(k)+'.png';
Oname1 = imread(Oname1);
Oname1=double(Oname1);
xxpicgather(1:XX,1:YY,1:3,k)=Oname1;
% read original rgb value
VR(1:XX,1:YY,k) = Oname(:,:,1);
VG(1:XX,1:YY,k) = Oname(:,:,2);
VB(1:XX,1:YY,k) = Oname(:,:,3);
end

[aim,aim1]=tubevoxel(XX,YY,ZZ,x0,y0,z0,l,theta,phi,d,crossectR);
%calculate the percentage
[nn,mm]=size(aim);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%display tissue model
num1 =[1:1:ZZ];
k1=1;
[x,y] = meshgrid(1:XX,1:YY); %!!!!y,x rotate
for k2=1:ZZ
    z = k1*ones(XX,YY);
    %b = surf(x,y,z,double(opicgather(:,:,num1(k2))));
    b = surf(x,y,z,double(xxpicgather(:,:,1:3,num1(k2))));
  %colormap(gray);
  grid off
  set(b,'linestyle','none');
  view(3);hold on;
  k1=k1+1;
end
 daspect([10,10,10]);

%color interpolation  
aim1x=reshape(aim1(:,1),d-1,[]);
aim1y=reshape(aim1(:,2),d-1,[]);
aim1z=reshape(aim1(:,3),d-1,[]);
%interpolation method   
VRq = interp3(VR,aim1x,aim1y,aim1z,'linear',255);
VGq = interp3(VG,aim1x,aim1y,aim1z,'linear',255);
VBq = interp3(VB,aim1x,aim1y,aim1z,'linear',255);
origion3(:,:,1)=VRq;
origion3(:,:,2)=VGq;
origion3(:,:,3)=VBq;
figure;
imshow(uint8(origion3)); %Uint8 can show the cross-section
hold on;

%calculate the percentage

for jj1=1:nn
O(jj1)=opicgather(aim(jj1,1),aim(jj1,2),aim(jj1,3));
end

NumH0= sum(sum(O==1));% H is blue voxel
NumE0= sum(sum(O==150));% E is red voxel
NumB0= sum(sum(O==0));
ratio=NumH0/(NumH0+NumE0)
