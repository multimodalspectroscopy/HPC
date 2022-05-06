function rev_art = rev_artifact_detect(hbo, hhb, task_freq,fs)
%Method detects blocks where HbO isblargely negative and HHb is largely poistive
%INPUTS:
%HbO = HbO time course for one channel, given as row vector
%HHb = HHb time course for one channel, given as row vector
%task_freq = Task related frequency, same as provided to computation of HPC
% fs = Sample frequency of input data



window_time = 1/task_freq;
window_samples = window_time*fs;
n_samples = size(hbo);
n_windows = fix(n_samples/window_samples);
hbdiff = hbo - hhb;

for bl = 1:n_windows
    start_block = 1+(bl-1)*window_samples;
    end_block = min(start_block+window_samples-1,n_samples);
    start_block =round(start_block);
    end_block = round(end_block);
    fprintf('start block %d = %f \n',bl,t(start_block))
    fprintf('end block %d = %f \n', bl,t(end_block))
    diff_block_norm = hbdiff(start_block:end_block);
    diff_block_norm = zscore(diff_block_norm);
    diff_x_y = [1:1:length(diff_block_norm); diff_block_norm']'; %put coords of block in X,Y array. First col is sampels, second is y vals
    ints = InterX(diff_x_y',[zeros(1,length(diff_block_norm)); 1:1:length(diff_block_norm)]); %get points where diff crosses into negative
    itsx = ints(2,:); %get x coordinates of intersections
    diffarea = [];
    areas = length(itsx)+1;
    for n_area = 1:areas
        if n_area ==1
            if round(itsx(n_area)) == 1
                continue %if first intersection is at 1 skip to next area (cant compute area of region defined by 1:1)
            else
                itsx_e = round(itsx(n_area));
            end
            diffarea(n_area) = trapz(diff_x_y(1:itsx_e,1), diff_x_y(1:itsx_e,2));
        elseif n_area == areas
            diffarea(n_area) = trapz(diff_x_y(floor(itsx(n_area-1)):length(diff_block_norm),1), diff_x_y(floor(itsx(n_area-1)):length(diff_block_norm),2));
        else
            diffarea(n_area) = trapz(diff_x_y(floor(itsx(n_area-1)):floor(itsx(n_area)),1), diff_x_y(floor(itsx(n_area-1)):floor(itsx(n_area)),2));
        end
    end
    area_neg = sum(diffarea(find(diffarea<0))); %find negative areas
    area_pos = sum(diffarea(find(diffarea>0))); %find positive areas
    art_check = abs(area_pos)/abs(area_neg);
    if round(art_check) < 1
        warning('HbO and HHB reversed')
        rev_art(bl) = art_check;
    else
        rev_art(bl) = NaN;
    end
end



end