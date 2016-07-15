function [traj,roiIndex]=trajectory(goal,robot,map,rois)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
edge=[robot,goal];
dist=edgeLength(edge);
traj=edgeToPolyline(edge, dist);
traj=unique(round(traj),'rows');
[Found,trajIndex,roiIndex]=intersectROI(traj,rois,1,1);
if(~Found)
    disp('ROI not Found!!');
    roiIndex=[];
else
    traj=traj(1:trajIndex,:);
end
end


