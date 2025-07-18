function SSR = projection_rbc_residual(coef,grid,GH,params,ln_c)

SSR =  0;
for k_curr = grid.k(:)'
    for z_curr = grid.z(:)'
        % approximate with polynomial of order 2
        c_curr = exp(ln_c(k_curr,z_curr,coef));
        k_fwrd = z_curr*k_curr^params.ALPHA + (1-params.DELTA)*k_curr - c_curr;
        expec = 0;
        for i_q = 1:GH.number
            e_fwrd = sqrt(2)*params.SIGMA*GH.nodes(i_q);
            z_fwrd = params.RHO*log(z_curr) + e_fwrd;
            z_fwrd = exp(z_fwrd);
            c_fwrd = exp(ln_c(k_fwrd,z_fwrd,coef));
            expec = expec + GH.weights(i_q) * ...
                    params.BETA*c_fwrd^(-params.TAU)*(params.ALPHA*z_fwrd*k_fwrd^(params.ALPHA-1)+(1-params.DELTA));   
        end
        expec = expec/sqrt(pi);
        SSR = SSR + (expec-c_curr^(-params.TAU))^2;
    end
end