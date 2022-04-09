%% Import Data
%input X - each column represents a single timepoint with a 'data
%state' for each neuron in the form of Delta F / Delta t.

%Import your matrix as you see fit, copy and pasted from imagej multimeasure
%can be done from the Home Tab - new variable which will then have to be
%transposed as: 
%X=unnamed'

[tM,dM]=size(X);

%% Archetypal Analysis
% Takes  Therefore each
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

