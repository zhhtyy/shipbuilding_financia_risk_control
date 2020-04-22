%% 从文本文件中导入数据
% 用于从以下文本文件中导入数据的脚本:
%
%    filename: C:\Users\zhang\OneDrive\Desktop\FO_GO comparison.csv
%
% 由 MATLAB 于 2020-04-19 22:44:52 自动生成

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 6);

% 指定范围和分隔符
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["DATE", "FOREX", "GO", "FOCNY", "FO", "GO_FOspread"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 指定变量属性
opts = setvaropts(opts, "DATE", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "DATE", "EmptyFieldRule", "auto");

% 导入数据
FOGOcomparison1 = readtable("C:\Users\zhang\OneDrive\Desktop\FO_GO comparison.csv", opts);


%% 清除临时变量
clear opts