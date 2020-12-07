function writeMUAe(data, flag)

disp('Write MUAe-files...')
nChan = data.param.nChan;
nChan(nChan == 23) = [];
try
nChan(nChan == data.param.Mic) = [];
catch
end

for iCh = nChan
          
    % Import CSC
    if exist(['MUAe' num2str(iCh) '_car.ncs'], 'file') == 2                     
        fName               = ['CSC' num2str(iCh) '_car.ncs'];
        mName           	= [data.sdir 'MUAe' num2str(iCh) '_car.ncs'];
    else
        fName               = ['CSC' num2str(iCh) '.ncs'];
        mName              = [data.sdir 'MUAe' num2str(iCh) '.ncs'];
    end
    
    % Delecte or skip
    if flag == 1 && exist(mName,'file') == 2
        delete(mName)
    elseif flag == 0 && exist(mName,'file') == 2
        continue
    end
    
    settings.segmentSize    = 30000;
    settings.maxSegmentNum  = inf;
    NCS                     = NLX_LoadNCS(fName,'NOSAMPLES',1,[]);
    nRecsTotal              = length(NCS.TimeStamps)-1;
    nSegments               = min([settings.maxSegmentNum ceil(nRecsTotal/settings.segmentSize)]);
    
    ncs.Path                = NCS.Path;
    ncs.Header              = NCS.Header;
    ncs.TimeStamps          = [];
    ncs.ChNr                = [];
    ncs.SF                  = [];
    ncs.ValidSampleNum      = [];
    ncs.Samples             = [];
    
    for iSeg = 1:nSegments
        currRecIndex        = [0:settings.segmentSize-1] + settings.segmentSize .* (iSeg-1);
        currRecIndex        = currRecIndex(currRecIndex<=nRecsTotal);
        NCS                 = NLX_LoadNCS(fName,'FULL',3,currRecIndex);
        ncs.TimeStamps      = cat(2, ncs.TimeStamps, NCS.TimeStamps);
        ncs.ChNr            = cat(2, ncs.ChNr, NCS.ChNr);
        ncs.SF              = cat(2, ncs.SF, NCS.SF);
        ncs.ValidSampleNum  = cat(2, ncs.ValidSampleNum, NCS.ValidSampleNum);
        ncs.Samples         = cat(2, ncs.Samples, NCS.Samples);
    end
    
    % Compute MUAe
    MUAe                    = NLX_NCS2MUAe(ncs,[],false,[data.sdir mName]);
            
    AppendFile              = 0;
    ExtractMode             = 1;
    NumRecs                 = length(MUAe.TimeStamps);
    TimeStamps              = MUAe.TimeStamps;
    FieldSelection          = [1 1 1 1 1];
    ChannelNumber           = MUAe.ChNr;
    SampleFrequencies       = MUAe.SF;
    NumberValidSamples      = MUAe.ValidSampleNum;
    Samples                 = MUAe.Samples;
    NlxHeader               = MUAe.Header;
    
    Mat2NlxCSC(mName, AppendFile, ExtractMode, 1, NumRecs, [FieldSelection 1], TimeStamps, ChannelNumber, SampleFrequencies, NumberValidSamples, Samples, NlxHeader );
    if ~exist(mName, 'file')
        Mat2NlxCSC(mName, AppendFile, ExtractMode, 1, [FieldSelection 1], TimeStamps, ChannelNumber, SampleFrequencies, NumberValidSamples, Samples, NlxHeader );
    end
end

disp('Done!')

end