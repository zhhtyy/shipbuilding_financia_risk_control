%data manupulation
FOGOcomparison.DATE = datestr(FOGOcomparison.DATE)
FOGOcomparison.DATE = datenum(FOGOcomparison.DATE)
FOGOcomparison.DATE = datevec(FOGOcomparison.DATE)
FOGOcomparison.DATE = datetime(FOGOcomparison.DATE)
plot(FOGOcomparison.DATE,FOGOcomparison.GO_FOspread)
change1 = tick2ret(FOGOcomparison.GO_FOspread)
change2 = tick2ret(FOGOcomparison{:,[3 5]})

%variable creation on the portfolio
m = mean(change1)
c = cov(change1)
p = Portfolio
p = setAssetMoments(p,m,c)
p = setDefaultConstraints(p)
[risk,ret]=plotFrontier(p)

m2 = mean(change2)
c2 = cov(change2)
p2 = Portfolio
p2 = setAssetMoments(p2,m2,c2)
p2 = setDefaultConstraints(p2)
[risk,ret]=plotFrontier(p2)
createfigure(risk,ret,ret./risk)

%choosing no. of data points on the observation
step = 1;
Close = FOGOcomparison.GO_FOspread(1:step:end);

%choose period observation on the EMA and RSI backtesting
N = 200;
M = 50;
[sh pnl pos] = marisa(Close, N, M, 0.01);

posPNLPlot(Close, pos, pnl);

%Sharpe ratio calculation and visualization
fprintf('Sharpe''s Ratio: %0.2f\n\n', sh * sqrt(60*11/step));

N = 10:10:300;
M = 10:5:200;
cost = .01;

SH = zeros(length(N),length(M));
SHrow = zeros(1,length(M));
% loop over N,M
tic;
for i = 1:length(N)
    SHrow = zeros(1,length(M));
    for j = 1:length(M)
        SHrow(j) = marisa(Close, N(i), M(j), cost);
    end
    SH(i,:) = SHrow;
end
toc
SH = SH * sqrt(60*11/step);

clf
surfc(M,N,SH); shading interp; lighting phong; light
ylabel('EMA Parameter (N)');
xlabel('RSI Parameter (M)');
zlabel('Sharpe''s Ratio');

% Select Optimal Parameters
[I,J] = find(SH == max(max(SH)));
fprintf('\nOptimal Sharpe''s ratio of %0.2f was found for N = %d, M = %d\n', SH(I,J), N(I), M(J));

hold on;
plot3(M(J), N(I), SH(I,J), 'c*', 'MarkerSize', 8)
hold off;

%RERUN strategy test
[sh, pnl, pos] = marisa(Close, N(I), M(J), cost);
sh = sqrt(60*11/step) * sh;

tradeoffplot(Close, pos, pnl);
title(['Cumulative PNL. Sharpe = ',num2str(sh),', N=',num2str(N(I)),', M=',num2str(M(J))])


%CALCULATE average return
cpnl = cumsum(pnl);
[maxdd, period] = maxdrawdown(cpnl, 'arithmetic');
% Extract PNL for individual positions
ind = find(diff(pos)) + 1;
posPNL = diff([0;cpnl(ind)]);

% Display Histogram of Position Returns
histPNLPlot(cpnl, posPNL, period);

fprintf('Average position duration = %0.2f periods\n', mean(diff(ind)));
fprintf('Average profit per position = $%0.2f\n', mean(posPNL));
fprintf('\nTotal number of positions = %d\n', length(posPNL));
fprintf('Maximum Drawdown = $%0.2f\n\n', maxdd);