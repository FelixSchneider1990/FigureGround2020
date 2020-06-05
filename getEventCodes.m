function out = getEventCodes()

% Stimuli:
out.SFG             = [129 158];    % SFG event codes
out.PT              = [160 173];    % pure tones event codes
out.BPN             = [175 187];    % bandpass-noise event codes
out.CLK             = [188 191];    % click trains event codes

% General:
out.rewProvided     = 194;          % reward on
out.trialStart      = 198;

% FigDt:
out.barTouch        = 200;          % bar touched
out.figOn           = 201;          % figure onset
out.figEnd          = 202;          % figure end
out.MI_early        = 203;          % early miss
out.HI              = 204;          % hit
out.MI_late         = 205;          % late miss
out.FA              = 206;          % false alarm
out.CR              = 207;          % correct rejection
out.stimEnd         = 208;          % stimulus end
out.trialEnd        = 209;          % trial end
out.SFGstart        = 217;          % paradigm start
out.SFGend          = 218;          % paradigm end

% Tuning:
out.soundEnd        = 210;          % sound off
out.BLend           = 211;          % end of baseline period
out.tunStart        = 212;          % paradigm start
out.tunEnd          = 213;          % paradigm end
out.dB50            = 214;          % flag 50dB presentation
out.dB60            = 215;          % flag 60dB presentation
out.dB70            = 216;          % flag 70dB presentation

out.WNstart         = 221;          % White noise start
out.WNend           = 222;          % White noise end
out.WNon            = 199;          % White noise on
out.WNoff           = 210;          % White noise off

end