
function out = corrmeasures(vect1, vect2)
%measures of correlation
%returns an array to be put in a table that consits of [cov, corr]
var_cov = array2table(cov(vect1, vect2));
var_corr = array2table(corrcoef(vect1, vect2));

% return matrix of cov and corrcoef has the relevant data in a /
var_cov = renamevars(var_cov, ["Var1", "Var2"], ["Var2", "Var1"]);
out = [var_cov(1, 2), var_corr(1, 2)];
end