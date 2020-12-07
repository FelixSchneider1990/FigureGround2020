function out = getEvents()
% Import NLX event file (.nev)
% Felix Schneider, 03/2018

disp('Import Events.nev...')

[TimestampsEV, EventIDs, TTLs, Extras, EventStrings, HeaderEV] ...
    = Nlx2MatEV('Events.nev', [1 1 1 1 1], 1, 1, [] );  % get event file

TimestampsEV        = TimestampsEV./10^3;               % convert to ms
out.firstEV         = TimestampsEV(1);                  % get first event
out.timestamps      = TimestampsEV - out.firstEV;       % align to first event
out.TTLs            = TTLs;
out.header          = HeaderEV;

disp('Done!')
end