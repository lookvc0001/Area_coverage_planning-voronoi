function centroids=updatePartition(part,act)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
centroids=cell2mat({part(:).center}');
box=[1 50 1 50];
if(~isempty(act))
    centroids=sortCandidate(act,centroids);
    fn=unique(centroids,'rows');
    while(length(fn)<3)
        centroids=sortCandidate(act,randomPointInBox(box, 4));
        fn=unique(centroids,'rows');
    end
end

end

function centroids=sortCandidate(acntr,centroids)
    taken=[];
    for point=acntr'
        ind=emin(centroids,point',taken);
        taken=[taken;ind];
        centroids(ind,:)=point';
    end

end

