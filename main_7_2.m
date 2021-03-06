clear all;clc;clf;
addpath dataSet voronoi functions
load(sprintf('bestEllipse%d',1))
%# simulation parameters
robot=[1 1];
rois=bestEllipse;
findROIs=[];
step=1;
% # generate voronoi partition with uniform samples
subplot(2,3,step)
bound=[1 50 1 50];
window=[-10 60 -10 60];
partition = vornoiPartition( bound);
viz.partition(partition);
axis(window)
%%
centroids=[];
for ii=1:length(partition)    
    centroids=[centroids;partition(ii).center];
end
x=centroids(:,1);
y=centroids(:,2);
% find the nearest centroid
centroid_mask=[];
ind=emin(centroids ,robot,centroid_mask );
centroid_mask=[centroid_mask;ind];

%%
% subplot(2,3,4)
for kk=1:length(partition)
 center(kk,:)=wallFollowingSearch( partition(kk),kk);
end
% centroids=center;
%%
while (step<2)
% update windows
subplot(2,3,step+1)
%connect the centroid 
edge=createEdge(robot, [x(ind), y(ind)]);
drawEdge(x(ind), y(ind), robot(1), robot(2));
% find intesection with any ellipse
candidateROIs  = found_roi( rois,edge );
%draw candidate rois
for ii=candidateROIs
    hold on
    drawEllipse(rois(ii,:)); 
end
%update area parition 
findROIs=[findROIs;rois(candidateROIs,:)];
centroids(ind,:)=rois(candidateROIs,1:2);
%update centroids


%update rois
rois(candidateROIs,:)=[];
%update robot position 
robot=[13.3243    6.6890]
step=step+1;

% plot(x,y,'r+',vx,vy,'b-')
partition = vornoiPartition( bound,centroids);
subplot(2,3,step+2);
viz.partition(partition);
%move to next candidate
ind=3;
end