function b=dfbint(nfun,p,c)
%
% function b=dfbint(nfun,p,c)
%
% Computes the b-coefficient in the describing function
%
% nfun - name of nonlinearity, e g deadzfun, satfun,...
% p    - parameter vector of nonlinearity
% c    - amplitude
%
N=100;
al=(0:N)*2*pi/N;
sal=sin(al);
ivals=feval(nfun,sal'*c,p).*(sal'*ones(1,length(c)));
b=(2*sum(ivals)-ivals(1,:)-ivals(N+1,:))/N;

