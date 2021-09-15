%% load observed spatiotemporal data (sea-surface temperature anomalies)
load IP_SSTA_ERSSTv4.mat

% lagged 2D embedding, lagged by 12 months, stepping in 1 month steps
lag=12;
advance=1;

if lag,
    X=[x(:,1:end-lag); x(:,1+lag:end)];
end

%% Compute square pairwise distances
if lag,
    S = dmat( X( :, 1 : end - advance ), X( :, advance + 1 : end ) );  
else
     S = dmat( x( :, 1 : end - advance ), x( :, advance + 1 : end ) );
end

%% Compute kernel, perform Markov normalization
epsilon=20;
P = exp( - S / epsilon ^ 2 );
P=P./sum(P);

% Compute leading eigenspectrum/vectors
[u,v]=eigs(P,15);

%% load Nino3.4 indices for comparison
load nino_indices.mat

% Plot angle comparisons
figure
subplot(2,1,1)
plot(1970.5:1/12:2019.5,angle(u(:,6)),'.')
xlabel('year')
ylabel('ENSO phase (angle)')
title('Transfer operator cycle')
subplot(2,1,2)
plot(1970.5:1/12:2019.5,angle(complex(Nino34.idx(13:end-1),Nino34.idx(1:end-13))),'.')
title('Nino 3.4 index cycle') 
xlabel('year')
ylabel('ENSO phase (angle)')


