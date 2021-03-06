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
% visulization.drawEdgeSet(edges);
end

function edges=addEdgeBox(box,points)
%     find the points for each BoxEdge
    mat=isPointOnEdge(points, box);
    edges=[];
    for i=1:size(box,1)
       col=mat(:,i);
       inds=find(col==1);
%       Edges:--> all combination indices 
        C=combnk(inds,2);
        for iNe=C'
            edges=[edges;[points(iNe(1),:),points(iNe(2),:)]];            
        end
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





