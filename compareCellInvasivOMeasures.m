%     compare-Cell Invasiv-o-Measures: fuction that analyzes the outputs of Cell-Invasiv-O-Meter.
%     Copyright (C) 2015  Marilisa Cortesi
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 2 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.


function [areaDecrease,invasivity]=compareCellInvasivOMeasures(folderMat,control, conditions,timepoints)
currentFolder=pwd;
cd(folderMat)

filesMat=dir('*.mat');
cd(currentFolder)
[x,y]=size(conditions);
area=zeros(x+1,length(timepoints));
for f=1:length(filesMat)
    fileNameMat=filesMat(f).name();
    if fileNameMat(1)=='.'
        continue
    else
        load(strcat(folderMat,fileNameMat))
        id=regexp(fileNameMat, '_', 'split');
        time=regexp(char(id(2)), '.mat', 'split');
        time_index=find(str2double(char(time(1)))==timepoints);
        if strcmp(id(1), control)
            area(1,time_index)=mean(woundArea);
        else
            index=find(strcmp(id(1),conditions));
            area(index+1,time_index)=mean(woundArea);
        end
        
    end
    
end

areaNorm=zeros(x+1,length(timepoints));
for i=1:length(area(:,1))
    for j=1:length(area(1,:))
        areaNorm(i,j)=area(i,j)./area(1,1);
    end
end
figure()
bar(areaNorm)
set(gca,'XTickLabel',{control,conditions})
title('Wound Area (normalized to the control at time 0)')
areaDecrease=zeros(x+1,length(timepoints)-1);
for i=1:length(areaDecrease(:,1))
    for j=1:length(areaDecrease(1,:))
       areaDecrease(i,j)=(areaNorm(i,j+1)-areaNorm(i,j))/areaNorm(i,1);
    end
end
if length(timepoints)-1>1
    aveInvasivity=mean(areaDecrease);
else
    aveInvasivity=areaDecrease;
end
invasivity=zeros(1,length(aveInvasivity));
for i=1:length(invasivity)
    invasivity(i)=aveInvasivity(i)/aveInvasivity(1);
end
