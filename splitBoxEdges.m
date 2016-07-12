function [ edges ] = splitBoxEdges( boxEdges,interSects )
%FUNCTIONS 
% addEdgeBox: get box edges w.r.t intersction points
% duplicateEdgeRemove (center point based apporoach)

c=reshape(boxEdges,[size(boxEdges,1)*2,2]);
cc=unique(c,'rows');
edges=[];
newEdge=addEdgeBox(boxEdges,[interSects;cc]);
edges=[edges;newEdge];
edges=duplicateEdgeRemove(1, edges);
visulization.drawEdgeSet(edges);
end

function edges=addEdgeBox(box,points)
%     find the points for each BoxEdge
    mat=isPointOnEdge(points, box);
    edges=[];
    for i=1:size(box,1)
       col=mat(:,i);
       inds=find(col==1);
       n=length(inds);
       %     addEdge for all points on a BoxEdge
       p1s=points(inds(1),:);
       for j=1:n-1
           p1=points(inds(j),:);
           p2=points(inds(j+1),:);
           edges=[edges;[p1,p2]];
       end
       p2e=points(inds(n),:);
%        update edges
       edges=[edges;[p1s,p2e]];
    end
end



function edgeSet=duplicateEdgeRemove(count, edgeSet)
% find the center of each edge
% get the matrix of isPointOnEdge
% If a point can be found more than one, remove it.
edge=edgeSet(count,:);
[p1,p2]=edge2point(edge);
n=size(edgeSet,1);
center=(p1+p2)./2;
mat=isPointOnEdge(center, edgeSet);
index=find(mat==1);
if(length(index)>1)
    len = edgeLength(edgeSet(index,:));
    [val,inc]=max(len);
    edgeSet(index(inc),:)=[];
end
if(count<n-1)
    edgeSet=duplicateEdgeRemove(count+1, edgeSet);
end

end


function [p1,p2]=edge2point(e)
    p1=e(1,1:2);
    p2=e(1,3:4);
end


