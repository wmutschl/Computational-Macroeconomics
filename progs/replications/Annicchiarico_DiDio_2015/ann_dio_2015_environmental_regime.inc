%-------------------------------------------------------------------------%
% environmental regime
%-------------------------------------------------------------------------%
@#ifdef NO_POLICY
  [name='A(26) abatement effort']
  u = 0;
@#else
  [name='A(26) abatement effort']
  VARPHI * pz = PHI_1 * PHI_2 * u^(PHI_2-1);
@#endif

@#ifdef NO_POLICY
  [name='environmental policy regime: no policy (p.6 bottom)']
  pz = 0;
@#endif

@#ifdef CAP_AND_TRADE
  [name='environmental policy regime: cap-and-trade (p.6 bottom)']
  z = TARGET_ZSHARE*DELTA_M*TARGET_M;
@#endif

@#ifdef INTENSITY_TARGET
  [name='environmental policy regime: intensity target (p.7 top)']
  z = TARGET_INTENSITY*y;
@#endif

@#ifdef TAX_POLICY
  [name='environmental policy regime: tax policy (p.7 top)']
  pz = CARBON_TAX;
@#endif