
%Find the optimal solution of charging point
%-------------------------------------------------------------------------

% We limit the number of charging points set to 4 and find the points 
% that maximizes the number of charging points covered.
P = xlsread("Location_Data.xlsx", "Distance", "B46:AO85")
[m,n]=size(P);
A=[-P,eye(m)]; 
b=zeros(m,1); 
beq=[4];
Aeq=[ones(1,m),zeros(1,m)];
lb = zeros(2*m,1);
ub = ones(2*m,1);
int = [1:2*m]';
c=[zeros(m,1);ones(m,1)];
[x,z]=intlinprog(-c,int,A,b,Aeq,beq,lb,ub);
x=round(x) 
z=-z 
I1 = find(x(1:m)==1)

% There is no point that only covers two charging points.
% so we only have 1 combination 2-16-25-29, and 38 is the maximum points
% that can be covered by limited in 4 charging points.
for i = I1'
    sum(P(i,:)) 
end




