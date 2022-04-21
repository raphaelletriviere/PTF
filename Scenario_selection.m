function  [ScenarioProb] =Scenario_selection(ScenarioProb)

%%%%%%%%%%%%%%%%%%
%Sampling scenarii
%%%%%%%%%%%%%%%%%%
Num_scenario=10;

%Random value
al_val=rand(Num_scenario);  

Cum_Prob_BS=cumsum(ScenarioProb.ProbScenBS);
%ech_prob_BS=zeros(Num_scenario,1);
ind_BS=zeros(Num_scenario,1);

%Selection random value inside Cumulative Probability 
for i=[1:length(al_val)]
    mini=max(find(Cum_Prob_BS<al_val(i)));
    %ech_prob_BS(i)=mini
    ind_BS(i)=mini;
end

%Delete identic scenarii and Calculate probability
%for i=[1:length(ech_prob_BS)]
%    ind_BS(i)=find(Cum_Prob_BS==ech_prob_BS(i));
%end

ScenarioProb.ParScenBS_ID=ScenarioProb.ParScenBS_ID(ind_BS,:);
[C_BS,ia,ic]=unique(ScenarioProb.ParScenBS_ID);

ScenarioProb.ParScenBS=ScenarioProb.ParScenBS(C_BS,:);
ScenarioProb.ProbScenBSFact=ScenarioProb.ProbScenBSFact(C_BS,:);
 
rep_BS=zeros(length(C_BS),1);
for i=[1:length(C_BS)]
    rep_BS(i)=length(find(C_BS(i)==ScenarioProb.ParScenBS_ID));
end 

ScenarioProb.ParScenBS_ID=C_BS;
ScenarioProb.ProbScenBS=zeros(length(ScenarioProb.ParScenBS_ID),1);

for i=[1:length(ScenarioProb.ProbScenBS)]
    ScenarioProb.ProbScenBS(i)=rep_BS(i)/Num_scenario;
end


%%%%%%%
% Sampling PS scenarii, if requiered
Tot_ProbScen=sum(ScenarioProb.ProbScenPS);

if Tot_ProbScen>0
   Cum_Prob_PS=cumsum(ScenarioProb.ProbScenPS);
   ech_prob_PS=zeros(Num_scenario,1);

   %Selction random value inside Cumulative Probability 
   for i=[1:length(al_val)]
       [mini,indice]=min(abs(Cum_Prob_PS-al_val(i)));
       ech_prob_PS(i)=Cum_Prob_PS(indice);
   end

   %Delete identic scenarii and Calculate probability
   ind_PS=zeros(Num_scenario,1);
   for i=[1:length(ech_prob_PS)]
       ind_PS(i)=find(Cum_Prob_PS==ech_prob_PS(i));
   end

   ScenarioProb.ParScenPS_ID=ScenarioProb.ParScenPS_ID(ind_PS,:);
   [C_PS,ia,ic]=unique(ScenarioProb.ParScenPS_ID);

   ScenarioProb.ParScenPS=ScenarioProb.ParScenPS(C_PS,:);
   ScenarioProb.ProbScenPSFact=ScenarioProb.ProbScenPSFact(C_PS,:);
 
   rep_PS=zeros(length(C_PS),1);
   for i=[1:length(C_PS)]
       rep_PS(i)=length(find(C_PS(i)==ScenarioProb.ParScenPS_ID));
   end 

   ScenarioProb.ParScenPS_ID=C_PS;
   ScenarioProb.ProbScenPS=zeros(length(ScenarioProb.ParScenPS_ID),1);

   for i=[1:length(ScenarioProb.ProbScenPS)]
      ScenarioProb.ProbScenPS(i)=rep_PS(i)/Num_scenario;
   end

    
end