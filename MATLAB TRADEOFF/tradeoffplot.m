function tradeoffplot(x, pos, pnl)

% Copyright 2013 MathWorks, Inc.

changePos = [false; logical(diff(pos))];

ax1 = subplot(2,1,1);
plot(x);
hold on;
ind = find(pos == 1 & changePos);
plot(ind, x(ind), 'g^', 'Markersize', 6, 'MarkerFaceColor', 'g');
ind = find(pos == -1 & changePos);
plot(ind, x(ind), 'rv', 'Markersize', 6, 'MarkerFaceColor', 'r');
ind = find(pos == 0 & changePos);
plot(ind, x(ind), 'k*', 'Markersize', 4);
hold off;
legend('(GO-FO) spread','choose scrubber', 'switch to GO', 'either option');
grid on;
ylabel('Price');
title('(GO-FO) spread time seires');
ax2 = subplot(2,1,2);
plot(cumsum(pnl));
title('Cumulated Profit/Loss');
ylabel('Profit/Loss');
grid on;
linkaxes([ax1 ax2],'x');
area(cumsum(pnl),0)