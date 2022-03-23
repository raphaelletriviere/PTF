function  [ScenarioProb] =Scenario_selection(ScenarioProb)

%%%%%%%%%%%%%%%%%
%Sampling scenarii 
% Insert this function in PTF_1_0.m after the line 691
%%%%%%%%%%%%%%%%%

% Sampling BS, if requiered
Cumul_ProbBS=cumsum(ScenarioProb.ProbScenBS);             %Cumulate Probabilities
ind_BS=randi([1 length(ScenarioProb.ProbScenBS)],1000,1); %Generate random number between 1 and the number of scenarii to build a vector 1000x1
ind_BS=sort(ind_BS);                                      
ProbScenBS=Cumul_ProbBS(ind_BS,:);

%Modification ScenarioProb structure to obtain only 1000 scenarii in each matrix
ScenarioProb.ProbScenBS=ProbScenBS;
ScenarioProb.ParScenBS_ID=ScenarioProb.ParScenBS_ID(ind_BS,:)
ScenarioProb.ParScenBS=ScenarioProb.ParScenBS(ind_BS,:)
ScenarioProb.ProbScenBSFact=ScenarioProb.ProbScenBSFact(ind_BS,:)

% Sampling PS scenarii, if requiered
Tot_ProbScen=sum(ScenarioProb.ProbScenPS);

if Tot_ProbScen>0
    Cumul_ProbPS=cumsum(ScenarioProb.ProbScenPS);
    ind_PS=randi([1 length(ScenarioProb.ProbScenPS)],1000,1);
    ind_PS=sort(ind_PS);
    ProbScenPS=Cumul_ProbBS(ind_PS,:);

   ScenarioProb.ProbScenPS=ProbScenPS
   ScenarioProb.ParScenPS_ID=ScenarioProb.ParScenPS_ID(ind_PS,:)
   ScenarioProb.ParScenPS=ScenarioProb.ParScenPS(ind_PS,:)
   ScenarioProb.ProbScenPSFact=ScenarioProb.ProbScenPSFact(ind_PS,:)
end 

% RENORMALIZING (TO MANAGE EVENTS OUTSIDE nSigma, BS OF LARGE MAGNITUDES, ETC.
ScenarioProb.TotProbBS_preNorm = sum(ScenarioProb.ProbScenBS);
ScenarioProb.TotProbPS_preNorm = sum(ScenarioProb.ProbScenPS);
ScenarioProb.TotProb_preNorm = ScenarioProb.TotProbBS_preNorm + ScenarioProb.TotProbPS_preNorm;

if ScenarioProb.TotProb_preNorm < 1.0
    ScenarioProb.ProbScenBS = ScenarioProb.ProbScenBS / ScenarioProb.TotProb_preNorm;
    ScenarioProb.ProbScenPS = ScenarioProb.ProbScenPS / ScenarioProb.TotProb_preNorm;
end