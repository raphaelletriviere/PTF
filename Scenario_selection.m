function  [ScenarioProb] =Scenario_selection(ScenarioProb)

%Cumulative Probabilities 

% BS
Cumul_ProbBS=cumsum(ScenarioProb.ProbScenBS);
ind_BS=randi([1 length(ScenarioProb.ProbScenBS)],1000,1);
ind_BS=sort(ind_BS);
ProbScenBS=Cumul_ProbBS(ind_BS,:);

ScenarioProb.ProbScenBS=ProbScenBS;
ScenarioProb.ParScenBS_ID=ScenarioProb.ParScenBS_ID(ind_BS,:)
ScenarioProb.ParScenBS=ScenarioProb.ParScenBS(ind_BS,:)
ScenarioProb.ProbScenBSFact=ScenarioProb.ProbScenBSFact(ind_BS,:)

% PS
Cumul_ProbPS=cumsum(ScenarioProb.ProbScenPS);
ind_PS=randi([1 length(ScenarioProb.ProbScenPS)],1000,1);
ind_PS=sort(ind_PS);
ProbScenPS=Cumul_ProbBS(ind_PS,:);

ScenarioProb.ProbScenPS=ProbScenPS
ScenarioProb.ParScenPS_ID=ScenarioProb.ParScenPS_ID(ind_PS,:)
ScenarioProb.ParScenPS=ScenarioProb.ParScenPS(ind_PS,:)
ScenarioProb.ProbScenPSFact=ScenarioProb.ProbScenPSFact(ind_PS,:)

ScenarioProb.TotProbBS_preNorm = sum(ScenarioProb.ProbScenBS);
ScenarioProb.TotProbPS_preNorm = sum(ScenarioProb.ProbScenPS);
ScenarioProb.TotProb_preNorm = ScenarioProb.TotProbBS_preNorm + ScenarioProb.TotProbPS_preNorm;