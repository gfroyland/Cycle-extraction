function d=distfun_3d(x1,x2)

%x1,x2 are nx2 arrays creates nxn matrix d of pairwise distances in 3d
%euclidean space

n=size(x1,1);
d=zeros(n,n);


for i=1:n,
    cpy=ones(n,1)*x1(i,:);
    dm=vecnorm(cpy-x2,2,2);
    d(i,:)=dm;
end
    
    