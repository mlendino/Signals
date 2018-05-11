%thank you to aziza for helping me think through this conceptually
function est = rEstimate(x,m)
est = zeros(length(x) - m,1);

for ii = 1:1:length(est)
    est(ii) = x(ii + m - 1)*x(ii);
end
 
est = est / (length(x) - m);
est = sum(est);

end
