
%Step1: Find the optimal solution of charging point using greedy algorithm
%-------------------------------------------------------------------------

P = xlsread("Location_Data.xlsx", "Distance", "B46:AO85")
s = 40;
H1 = zeros(s);
for c = 1:s
   H1(c,1:sum(P(c,:)==1)) = find(P(c,:)==1)
end
X =setcover(H1)
I1 = find(X==1)

% Find the point that only covers two charging points.
% Because this type of points can be combined with fixed points.
for i = I1
   sum(P(i,:)) 
end



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
a3 = [1];
a4 = [12];
a5 = [16];
a6 = [22];
a7 = [23];
a8 = [27];
a9 = [38];
c = combvec(a1,a2,a3,a4,a5,a6,a7,a8,a9)'

%Select best portfolio
F2 = CostFactor(c',1)
F3 = reshape(F2,9,4)
F4 = sum(F3)
I2 = find(F4==min(sum(F3))) 
bestportfolio = c(I2,:)

%-------------------------------------------------------------------------

function result=setcover(covby)

    %finding all the elements in the universe
    universe=unique(covby);
    universe(universe==0)=[];
    %universe=universe';
    result=zeros(1,length(covby));

    %finding each set size
    count=zeros(1,length(covby));
    for i=1:length(covby)
        a=covby(i,:);
        a(a==0)=[];
        count(i)=length(a);
    end

    %finding the row with maximum size set
    [~,place]=sort(count,'descend');

    for i=1:length(covby)
        a=covby(place(i),:);
        a(a==0)=[];
        for j=1:length(a)
            for k=1:length(universe)
                if(a(j)==universe(k))
                    universe(k)=0;
                    result(place(i))=1;
                    break;
                end
            end
        end    
        if(sum(universe)==0)
            break
        end
    end
end



