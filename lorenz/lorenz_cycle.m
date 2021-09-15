%create Lorenz trajectory
sigma = 10;
beta = 8/3;
rho = 28;
f = @(t,a) [-sigma*a(1) + sigma*a(2); rho*a(1) - a(2) - a(1)*a(3); -beta*a(3) + a(1)*a(2)];
[t,x] = ode45(f,0:.01:160,[1 1 25]); 

%compute distance matrix
S=distfun_3d(x(1:end-1,:),x(2:end,:));

%set bandwidth
epsilon=0.5;

% Compute kernel, perform Markov normalization
P = exp( - S.^2 / epsilon ^ 2 );
P=P./sum(P);

%compute leading eigenspectrum/vectors
[u,v]=eigs(P');
figure
scatter3(x(1:end-1,1),x(1:end-1,2),x(1:end-1,3),3,u(:,2),'filled')

