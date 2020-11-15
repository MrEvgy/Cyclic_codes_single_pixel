function [DistMatrix] = CalcVertexDist(SimParam)
%Calc Vertexs and calc the distance to the farthest vertex of each hexagon 

%% Extract Parameters
X = SimParam.X;
Y = SimParam.Y;
dx = SimParam.dx;

%% Calc vertex postions
VertixMatX = zeros([size(X),6]);
VertixMatY = zeros([size(Y),6]);
for ii = 0:5
    VertixMatX(:,:,ii+1) = X + 2/sqrt(3)*(dx/2)*cos(pi*(2*ii+1)/6);  %%%
    VertixMatY(:,:,ii+1) = Y + 2/sqrt(3)*(dx/2)*sin(pi*(2*ii+1)/6);
end

%% Calc farthest vertex
DistMatrix = sqrt((VertixMatX).^2+VertixMatY.^2); %Create matrix of distances
DistMatrix = max(DistMatrix,[],3);

end

