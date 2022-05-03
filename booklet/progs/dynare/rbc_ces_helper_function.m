function L = rbc_ces_helper_function(L0,pssi,etaL,etaC,gam,C_L,W)
    if etaC == 1 && etaL == 1
        L = gam/pssi*C_L^(-1)*W/(1+gam/pssi*C_L^(-1)*W);
    else
        options = optimset('Display','Final','TolX',1e-12,'TolFun',1e-12);
        L = fsolve(@(L) W*gam*C_L^(-etaC) - pssi*(1-L)^(-etaL)*L^etaC , L0,options);                        
    end
end