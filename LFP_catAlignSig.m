function fp = LFP_catAlignSig(fp, d, avg, id, coord, tf_frex)

% Initialise
if isempty(fieldnames(fp))
    fp.bl          = [];
    fp.bl_pow      = [];
    fp.bl_pownorm  = [];
    fp.bl_itpc     = [];
    
    fp.so          = [];
    fp.so_pow      = [];
    fp.so_itpc     = [];
    
    if isfield(d, 'fo4')
        fp.fo4        = [];
        fp.fo4_pow    = [];
        fp.fo4_itpc   = [];
        
        fp.fr4        = [];
        fp.fr4_pow    = [];
        fp.fr4_itpc   = [];
    else
        fp.fo12        = [];
        fp.fo12_pow    = [];
        fp.fo12_itpc   = [];
        
        fp.fr12        = [];
        fp.fr12_pow    = [];
        fp.fr12_itpc   = [];
    end
    
    fp.fo8         = [];
    fp.fo8_pow     = [];
    fp.fo8_itpc    = [];

    fp.fr8         = [];
    fp.fr8_pow     = [];
    fp.fr8_itpc    = [];
    
    %     fp.rmi         = [];
    %     fp.rmi_pow     = [];
    %     fp.rmi_itpc    = [];
    %
    %     fp.rfa         = [];
    %     fp.rfa_pow     = [];
    %     fp.tfa_itpc    = [];
    
    fp.rcr         = [];
    fp.rcr_pow     = [];
    fp.rcr_itpc    = [];
    
    if avg == 0
        fp.zmap8      = [];
        fp.diff8      = [];
        fp.extr8      = [];
    
        fp.zmap12     = [];
        fp.diff12     = [];
        fp.extr12     = [];
    
        fp.zmapF      = [];
        fp.diffF      = [];
        fp.extrF      = [];
        
        fp.id         = [];
        fp.coord      = [];
%         fp.field      = [];
    end
end


if avg == 1
    fp.bl         = cat(1, fp.bl , nanmean(d.bl.trAlign));              % baseline
    fp.bl_pow     = cat(3, fp.bl_pow, nanmean(d.bl.trPow,3));
    fp.bl_itpc    = cat(3, fp.bl_itpc, d.bl.ITPC);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Average power during baseline for normalisation %%%
    for i = 1:size(d.bl.trPow,3)
        tmp         = LFP_exclCycle(d.bl.trPow(:,:,i), tf_frex(1), tf_frex(2), tf_frex(3), 2);
        tmpp(:,i)	= nanmean(tmp,2);
    end
    fp.bl_pownorm 	= cat(2, fp.bl_pownorm, mean(tmpp,2));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fp.so         = cat(1, fp.so , nanmean(d.so.trAlign));              % sound onset
    fp.so_pow     = cat(3, fp.so_pow, nanmean(d.so.trPow,3));
    fp.so_itpc    = cat(3, fp.so_itpc, d.so.ITPC);
    
    if isfield(d, 'fo4')
        fp.fo4          = cat(1, fp.fo4 , nanmean(d.fo4.trAlign));        % figure onset coh12
        fp.fo4_pow      = cat(3, fp.fo4_pow, nanmean(d.fo4.trPow,3));
        fp.fo4_itpc     = cat(3, fp.fo4_itpc, d.fo4.ITPC);
        
        
        fp.fr4          = cat(1, fp.fr4 , nanmean(d.fr4.trAlign));        % figure response coh12
        fp.fr4_pow      = cat(3, fp.fr4_pow, nanmean(d.fr4.trPow,3));
        fp.fr4_itpc     = cat(3, fp.fr4_itpc, d.fr4.ITPC);
    else 
        fp.fo12         = cat(1, fp.fo12 , nanmean(d.fo12.trAlign));        % figure onset coh12
        fp.fo12_pow     = cat(3, fp.fo12_pow, nanmean(d.fo12.trPow,3));
        fp.fo12_itpc    = cat(3, fp.fo12_itpc, d.fo12.ITPC);
        
        
        fp.fr12         = cat(1, fp.fr12 , nanmean(d.fr12.trAlign));        % figure response coh12
        fp.fr12_pow     = cat(3, fp.fr12_pow, nanmean(d.fr12.trPow,3));
        fp.fr12_itpc    = cat(3, fp.fr12_itpc, d.fr12.ITPC);
    end
    
    fp.fo8         = cat(1, fp.fo8 , nanmean(d.fo8.trAlign));           % figure onset coh8
    fp.fo8_pow     = cat(3, fp.fo8_pow, nanmean(d.fo8.trPow,3));
    fp.fo8_itpc    = cat(3, fp.fo8_itpc, d.fo8.ITPC);
    
    fp.fr8         = cat(1, fp.fr8 , nanmean(d.fr8.trAlign));           % figure response coh8
    fp.fr8_pow     = cat(3, fp.fr8_pow, nanmean(d.fr8.trPow,3));
    fp.fr8_itpc    = cat(3, fp.fr8_itpc, d.fr8.ITPC);
    
    %     fp.rmi         = cat(1, fp.rmi , nanmean(d.rmi.trAlign));           % misses
    %     fp.rmi_pow     = cat(3, fp.rmi_pow, nanmean(d.rmi.trPow,3));
    %     fp.rmi_itpc    = cat(3, fp.rmi_itpc, d.rmi.ITPC);
    %
    %     fp.rfa         = cat(1, fp.rfa , nanmean(d.rfa.trAlign));           % false alarms
    %     fp.rfa_pow     = cat(3, fp.rfa_pow, nanmean(d.rfa.trPow,3));
    %     fp.rfa_itpc    = cat(3, fp.rfa_itpc, d.rfa.ITPC);
    
    fp.rcr         = cat(1, fp.rcr , nanmean(d.rcr.trAlign));           % correct rejections
    fp.rcr_pow     = cat(3, fp.rcr_pow, nanmean(d.rcr.trPow,3));
    fp.rcr_itpc    = cat(3, fp.rcr_itpc, d.rcr.ITPC);
    
else
    fp.bl          = cat(1, fp.bl, d.bl);              % baseline
    fp.bl_pow      = cat(3, fp.bl_pow, d.bl_pow);
    fp.bl_pownorm  = cat(3, fp.bl_pownorm, d.bl_pownorm);
    fp.bl_itpc     = cat(3, fp.bl_itpc, d.bl_itpc);
    
    fp.so          = cat(1, fp.so, d.so);              % sound onset
    fp.so_pow      = cat(3, fp.so_pow, d.so_pow);
    fp.so_itpc     = cat(3, fp.so_itpc, d.so_itpc);
    
    if isfield(d, 'fo4')
        fp.fo4        = cat(1, fp.fo4, d.fo4);            % figure onset coh12
        fp.fo4_pow    = cat(3, fp.fo4_pow, d.fo4_pow);
        fp.fo4_itpc   = cat(3, fp.fo4_itpc, d.fo4_itpc);
        
        fp.fr4        = cat(1, fp.fr4, d.fr4);            % figure response coh12
        fp.fr4_pow    = cat(3, fp.fr4_pow, d.fr4_pow);
        fp.fr4_itpc   = cat(3, fp.fr4_itpc, d.fr4_itpc);
    else
        fp.fo12        = cat(1, fp.fo12, d.fo12);            % figure onset coh12
        fp.fo12_pow    = cat(3, fp.fo12_pow, d.fo12_pow);
        fp.fo12_itpc   = cat(3, fp.fo12_itpc, d.fo12_itpc);
        
        fp.fr12        = cat(1, fp.fr12, d.fr12);            % figure response coh12
        fp.fr12_pow    = cat(3, fp.fr12_pow, d.fr12_pow);
        fp.fr12_itpc   = cat(3, fp.fr12_itpc, d.fr12_itpc);
    end
  
    fp.fo8         = cat(1, fp.fo8, d.fo8);             % figure onset coh8
    fp.fo8_pow     = cat(3, fp.fo8_pow, d.fo8_pow);
    fp.fo8_itpc    = cat(3, fp.fo8_itpc, d.fo8_itpc);

    fp.fr8         = cat(1, fp.fr8, d.fr8);             % figure response coh8
    fp.fr8_pow     = cat(3, fp.fr8_pow, d.fr8_pow);
    fp.fr8_itpc    = cat(3, fp.fr8_itpc, d.fr8_itpc);
    
    %     fp.rmi         = cat(1, fp.rmi, d.rmi);             % misses
    %     fp.rmi_pow     = cat(3, fp.rmi_pow , d.rmi_pow);
    %     fp.rmi_itpc    = cat(3, fp.rmi_itpc, d.rmi_itpc);
    %
    %     fp.rfa         = cat(1, fp.rfa, d.rfa);             % false alarms
    %     fp.rfa_pow     = cat(3, fp.tfa_pow, d.rfa_pow);
    %     fp.tfa_itpc    = cat(3, fp.tfa_itpc, d.rfa_itpc);
    
    fp.rcr         = cat(1, fp.rcr, d.rcr);             % correct rejections
    fp.rcr_pow     = cat(3, fp.rcr_pow, d.rcr_pow);
    fp.rcr_itpc    = cat(3, fp.rcr_itpc, d.rcr_itpc);  
    
    fp.zmap8      = cat(3, fp.zmap8, d.zmap(:,:,1));
    fp.diff8      = cat(3, fp.diff8, d.diff(:,:,1));
    fp.extr8      = cat(2, fp.extr8, d.extr(:,1));
    
    fp.zmap12     = cat(3, fp.zmap12, d.zmap(:,:,2));
    fp.diff12     = cat(3, fp.diff12, d.diff(:,:,2));
    fp.extr12     = cat(2, fp.extr12, d.extr(:,2));
    
    fp.zmapF      = cat(3, fp.zmapF, d.zmap(:,:,3));
    fp.diffF      = cat(3, fp.diffF, d.diff(:,:,3));
    fp.extrF      = cat(2, fp.extrF, d.extr(:,3));
    
    fp.id         = cat(1, fp.id, {id});
    fp.coord      = cat(1, fp.coord, coord);
    %     fp.field           = cat(1, fp.field, d.field);
    
end