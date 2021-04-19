function do = distFromZeroLog(x, pv, vars, domainCounts, psels)
    % returns difference from zero
    % sum_i|P(V_i|S=1) - \hat P(V_i|S=1)|.
    % x(i, j): P(S=1|X_i =j)
    instances = variableInstances(domainCounts(vars), false);
    [nInst, nV] = size(instances);
    logprodS = nan(1, nInst);
    for iInst=1:nInst
        logprodS(iInst) = sum(log(x(sub2ind(size(x),1:nV, instances(iInst, :))))); % for each instance, P(S_1=1|x_1^inst)*...*P(S_k=1|x_k^inst);
    end
    logpspab = log(pv)+logprodS; % for each instance, % for each instance, P(S_1=1|x_1^inst)*...*P(S_k=1|x_k^inst)*P(inst)
    denom = logsumexp(logpspab);
    ds = zeros(1, nInst);
    i=0;
    for iVar=1:nV
        psel = psels{iVar};
        for iVal =1:domainCounts(iVar)
            i=i+1;
           % sum(pspab(instances(:, iVar)==iVal)./denom)
            ds(i) = abs(logsumexp(logpspab(instances(:, iVar)==iVal)-denom)-log(psel(iVal)));
        end
    end
do = sum(ds);
end