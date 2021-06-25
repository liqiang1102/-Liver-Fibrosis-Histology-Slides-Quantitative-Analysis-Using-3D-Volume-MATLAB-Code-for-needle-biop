function [aim,aim1]=tubevoxel619(XX,YY,ZZ,x0,y0,z0,l,theta,phi,d, crossectR) 

x1=x0-l*sind(theta)*cosd(phi);
y1=y0-l*sind(theta)*sind(phi);
z1=z0-l*cosd(theta);
%build the tube
x=0:1:l;
y=-d/2:1:d/2;% rectangle side length is d
z=-d/2:1:d/2; %rectangle side width is d
[x,y,z] = meshgrid(x,y,z);
% contain the Voxel in the tube
r=sqrt(y.^2+z.^2);

t=false(size(x,1),size(x,2),size(x,3));
t(r<=d/2)=true;
clearvars r
ind = find(t);

aim(:,1)=x((ind))+1;
aim(:,2)=y((ind))+1;
aim(:,3)=z((ind))+1;
% release memory
clearvars x y z ind t 
%keep the x-y cross section z=0
id = aim(:,3)==0;
aim1= aim(id,:);
temp_aim(:,1) = aim1(:,1);
temp_aim(:,2) = aim1(:,2)*cosd(crossectR);
temp_aim(:,3) = aim1(:,2)*sind(crossectR);
%aim1(id,:) = [];
aim1(:,1) =  temp_aim(:,1);
aim1(:,2) =  temp_aim(:,2);
aim1(:,3) =  temp_aim(:,3);

%clear y,z;
% plot the voxel in the tube
%scatter3(aim(:,1),aim(:,2),aim(:,3) );
%hold on;
%rotation angle
htheta=90-theta;
htheta=-htheta;
phi=-phi;
% rotation matrix
Rz=[cosd(phi),sind(phi),0;-sind(phi),cosd(phi),0;0,0,1];
Ry=[cosd(htheta),0,sind(htheta);0,1,0;-sind(htheta),0,cosd(htheta)];
% rotation
aim=Ry*aim';
aim=Rz*(aim);
aim=aim';
%scatter3(aim(:,1),aim(:,2),aim(:,3));

aim1=Ry*aim1';
aim1=Rz*(aim1);
aim1=aim1';

%hold on;

aim=aim';
% add the displacement for the tube
p2=[x1,y1,z1];
siz=size(aim');
Vp2=repmat(p2,siz(1),1);
aim=aim'+Vp2;
aim1=aim1';
%displacement tube cross-section point
siz1=size(aim1');
Vp12=repmat(p2,siz1(1),1);
aim1=aim1'+Vp12;

clearvars Vp2 Vp12;
scatter3(aim1(:,1),aim1(:,2),aim1(:,3) );
hold on;
scatter3(aim(:,1),aim(:,2),aim(:,3) );
hold on;
aim=round(aim);
id =aim(:,1)<=0 ;
aim(id,:)=[];
id= aim(:,1)>XX;
aim(id,:)=[];
id= aim(:,2)<=0;
aim(id,:)=[];
id= aim(:,2)>YY;
aim(id,:)=[];
id = aim(:,3)<=0;
aim(id,:)=[];
id= aim(:,3)>ZZ;
aim(id,:)=[];
%aim=unique(aim,'rows','stable');%

%aim=uint8(aim);

end