
%Step1: 
% a)
% Find the optimal solution of charging point using Binary programming
%-------------------------------------------------------------------------

Location = xlsread("Location_Data.xlsx", "Distance", "B46:AO85")
[m,n]=size(Location);
A=-Location ;
b =-ones(m,1);
beq = [];
Aeq=[];
lb = zeros(m,1);
ub = ones(m,1);
int = [1:m]';
c=ones(m,1);
[x_a,z_a]=intlinprog(c,int,A,b,Aeq,beq,lb,ub);
x_a=round(x_a) 

locations=find(x_a==1)


%Step2: Add cost factor to select best portfolio
%-------------------------------------------------------------------------


%Cost factor
data = xlsread('Location_Data.xlsx','Distance','B46:AO85')
ans = sum(data,1)
rng(1);
LandCost = normrnd(100, 20, 40,1)
ManagementFee = normrnd(20, 5, 40, 1)
ElectricityCost = normrnd(10, 2, 40, 1)
E = [LandCost, ManagementFee, ElectricityCost]
Weight = [0.33,0.36,0.31]
F1 = E.*Weight
CostFactor = sum(F1')'
CostFactor = CostFactor./ans'

%Select best portfolio
a1 = find(P(4,:)==1);
a2 = find(P(6,:)==1);
a4 = [12];
a5 = [16];
a5 = [26];
a6 = [27];
c = combvec(a1,a2,a3,a4,a5,a6)'

%Select best portfolio
F2 = CostFactor(c',1)
F3 = reshape(F2,6,4)
F4 = sum(F3)
I2 = find(F4==min(sum(F3))) 
bestportfolio = c(I2,:)


