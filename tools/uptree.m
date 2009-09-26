function urlStr = uptree(n)

pwdStr = [pwd,filesep];
Ix = strfind(pwdStr,filesep);
N=numel(Ix);
if (N-n)<=0
    error(['Can',char(39),'t go up that many levels.'])
else
    urlStr = pwdStr(1:Ix(N-n));
end



