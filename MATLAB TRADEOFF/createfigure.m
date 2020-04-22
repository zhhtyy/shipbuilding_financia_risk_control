function createfigure(X1, Y1, ret1)
%CREATEFIGURE(X1, Y1, ret1)
%  X1:  x 数据的向量
%  Y1:  y 数据的向量
%  RET1:  y 数据的向量

%  由 MATLAB 于 07-Apr-2020 22:29:57 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 plot
plot(X1,Y1,'Parent',axes1,'Marker','o');

% 创建 title
title({'Efficient frontier',''});

box(axes1,'on');
hold(axes1,'off');
% 设置其余坐标区属性
set(axes1,'OuterPosition',[0 0.5 1 0.5]);
% 创建 axes
axes2 = axes('Parent',figure1);
hold(axes2,'on');

% 创建 plot
plot(X1,ret1,'DisplayName','ret./risk 与 risk','Parent',axes2,...
    'Color',[0.850980392156863 0.325490196078431 0.098039215686274]);

% 创建 title
title('Sharpe Ratio');

box(axes2,'on');
hold(axes2,'off');
% 设置其余坐标区属性
set(axes2,'OuterPosition',[0 0 1 0.5]);
