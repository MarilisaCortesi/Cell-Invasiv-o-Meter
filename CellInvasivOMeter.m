%     Cell Invasiv-o-Meter: fuction that measure the invasivity of a cell
%     culture in-vitro.
%     Copyright (C) 2015  Marilisa Cortesi
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.


function [file,path]=CellInvasivOMeter(folder)
folderScript=pwd; 
cd (folder)
% change the extension if files not in .tiff format
files=dir('*.tif');
cd(folderScript)
Name='init'; 
images=[];
 for f=1:length(files)
     fileName=files(f).name;
     disp(fileName)
     id=regexp(fileName, '_', 'split');
     if strcmp(id(1),Name)
         tmp2=imread(strcat(sprintf('%s/',folder),fileName));
         tmp2=tmp2(:,:,2);
         images=cat(3,images,tmp1);
     else
         tmp1=imread(strcat(sprintf('%s/',folder),fileName));
         tmp1=tmp1(:,:,2);
         Name=id(1);
     end
 end
 [X,Y,nIm]=size(images);
 channelArea=zeros(1,nIm);
 for j=1:nIm
     figure()
     subplot(2,2,1)
     imshow(images(:,:,j))
     title('Raw Image')
     J=entropyfilt(images(:,:,j),ones(45));
     Jvect=reshape(J,1,X*Y);
     subplot(2,2,2)
     imshow(J,[])
     title('local Entropy')
     subplot(2,2,3)
     hist(Jvect,100)
     title('local Entropy Histogram')
     th=graythresh(J./max(max(J)));
     BW=not(im2bw(J./max(max(J)),th));
     label=bwlabel(BW);
     props=regionprops(label,'Area');
     massimo=0;
     Areas=zeros(1,length(props));
     for i =1:length(props)
         Areas(i)=props(i).Area;
     end
     AreaSorted=sort(Areas,'descend');
     AreaPercent=cumsum(AreaSorted)/sum(Areas);
     th2=find(AreaPercent>=0.7);
     mask=zeros(1024,1280);
     for i=1:th2
         index=find(Areas==AreaSorted(i));
         indices=find(label==index);
         mask(indices)=1;
         channelArea(j)=channelArea(j)+AreaSorted(i);
     end
     out=imoverlay(images(:,:,j),mask,[1,0,0]);
     subplot(2,2,4)
     imshow(out)
     title('Recognized channel')
 end
 disp('mean Channel Area (px)')
 disp(mean(channelArea))
 disp('standard deviation')
 disp(std(channelArea))
 [file,path]=uiputfile('*.mat','Save the output file');
