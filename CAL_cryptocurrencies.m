

load BlueChipStockMoments

mret = MarketMean;
mrsk = sqrt(MarketVar);
cret = CashMean;
crsk = sqrt(CashVar);

data = xlsread('Stock_data.xlsx','data','I17:M28')
[~,names] = xlsread('Stock_data.xlsx','data','I16:M16')
C = cov(data) 
R = mean(data) 


p = Portfolio('AssetList', names, 'RiskFreeRate', CashMean);
p = setAssetMoments(p, R', C);

p = setInitPort(p, 1/p.NumAssets);
[ersk, eret] = estimatePortMoments(p, p.InitPort);

p = setDefaultConstraints(p);
pwgt = estimateFrontier(p, 20);
[prsk, pret] = estimatePortMoments(p, pwgt);
pwgtshpr_fully = estimateMaxSharpeRatio(p,'Method','direct');
[riskshpr_fully, retshpr_fully] = estimatePortMoments(p,pwgtshpr_fully);

q = setBudget(p, 0, 1);
qwgt = estimateFrontier(q, 20);
[qrsk, qret] = estimatePortMoments(q, qwgt);


%PLOT-------------------------------------------------------------------
pwgtshpr_direct = estimateMaxSharpeRatio(q,'Method','direct');
pwgtshpr_iter = estimateMaxSharpeRatio(q,'Method','iterative');
[riskshpr_diret, retshpr_diret] = estimatePortMoments(q,pwgtshpr_direct);
[riskshpr_iter, retshpr_iter] = estimatePortMoments(q,pwgtshpr_iter);

clf;
portfolioexamples_plot('Efficient Frontier with Capital Allocation Line', ...
                {'line', prsk, pret, {'EF'}, '-r', 2}, ...
                {'line', qrsk, qret, {'EF with riskfree'}, '-b', 1}, ...
                {'scatter', [mrsk, crsk, ersk, riskshpr_fully, riskshpr_diret, riskshpr_iter], ...
    [mret, cret, eret, retshpr_fully , retshpr_diret, retshpr_iter], {'Market', 'Cash', 'Equal','Sharpe fully invest', 'Sharpe diret','Sharpe iter'}}, ...
                {'scatter', sqrt(diag(C)), R', names, '.r'});  

Sharpratio = (retshpr_fully - cret) / (riskshpr_fully - crsk)