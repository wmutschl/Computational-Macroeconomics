function pos = varind(str,isendo)
% searches index of an exogenous variable
% 
% Input:
%    str   variable name as a string
%    isendo boolean: true search from the names of endogenous variables;
%    false search from the names of exogenous variables
% Return:
%    returns of the index in the matrix of variables
% Modified:
% 4.10.2013 by Antti Ripatti
% - added error message
global M_;
if isendo
  pos = strmatch(str,M_.endo_names,'exact');
else
  pos = strmatch(str,M_.exo_names,'exact');
end;
if isempty(pos)
  error('fake:fake','Could not find the name %s',str);
end;