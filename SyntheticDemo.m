clear
clc

%Generates synthetic calcium waves for dM neurons over tM frames.
dM=20; %Number of Neurons
tM=4*5*60; %Total observations [(Frames/Second)*(Seconds/Minute)*Minutes]

nCliques=10; %Number of Cliques
            %To tune for population, replace value with 
            %ceil(0.3*dM);

[dF,Events,Cliques]=generateCalcium(dM,tM,nCliques);
[tM,dM]=size(dF);

%% Archetypal Analysis
% Takes input X - each column represents a single timepoint with a 'data
% state' for each neuron in the form of Delta F / Delta t. Therefore each
% row can be observed as the signal of a single cell ober the recording
% period. The number of representative archetypes to map onto the convex
% hull (nArch) needs further optimization, however we recommend using
% [Beck et. al, IEEE EMBC 2022] to recommend a number of archetypes.

X=dF';
nArch=10;

U=1:size(X,2); % Entries in X used that is modelled by the AA model
I=1:size(X,2); % Entries in X used to define archetypes

delta=0; % AA recommended params
opts.maxiter=1000;
opts.conv_crit=1e-6;


[XC,S,C,SSE,varexpl]=PCHA(X,nArch,I,U,delta,opts); %Perform AA
             
Archetypes=ArchMapping(XC);%Identify Correlated Cells

%% Compare Reconstructed Archetypes to Original Cliques
CliqueDistribution=Archetype_Clique_Comparison(Cliques,Archetypes);





