%Enter the name of the file in the first column, sheet name in the second
%column, and the location and range of the data in the third column. If the
%range is undetermined, for example, the B column, simply put 'B:B' 

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,1,1) 
title('Original Data');
hold on
plot(time, data)

[pks , pks_time,w_peaks]=findpeaks(data,time);
[vs, vs_time,w_vs]=findpeaks(-data,time);
vs=-vs;

if z==1 %turn on 30% of max peak prominence for peak selection
pks_criteria=0.3*max(pks);
vs_criteria=0.3*max(vs);    
elseif z==2
    pks_criteria=0.50*max(pks);
vs_criteria=0.50*max(vs);
elseif z==3
    pks_criteria=avg_peaks;
    vs_criteria=avg_vs;
elseif z==4
    pks_criteria=0.70*max(pks);
vs_criteria=0.70*max(vs);
elseif z==5
    pks_criteria=0.95*max(pks);
vs_criteria=0.95*max(vs);
elseif z==6
    pks_criteria=0.97*max(pks);
vs_criteria=0.97*max(vs);
end


% Level Baseline to zero with spline function
%Ensure no high valley points that skew the base line
vs_new=[];
vs_time_new=[];
pk_diff_max=max(pks)-min(pks);
vs_diff_max=max(vs)-min(vs);

for x=1:length(vs)
if vs(x)<=(mean(data))
%Minus 10% from the mean of the data as the threshold
vs_new=[vs_new vs(x)];
vs_time_new=[vs_time_new vs_time(x)];
end
end    

if length(vs_new)<=3 
vs=vs;
vs_time=vs_time;
elseif pk_diff_max>=0.8
    if 0.7<=pk_diff_max/vs_diff_max<=1.5
    vs=vs;
    vs_time=vs_time;
    end
else
vs=vs_new;
vs_time=vs_time_new;
end

smoothing_spline=fit(vs_time',vs','smoothingspline');
plot(time,smoothing_spline(time))
detrenddata=data-smoothing_spline(time)';

[pks , pks_time,w_peaks]=findpeaks(detrenddata,time);
[vs, vs_time,w_vs]=findpeaks(-detrenddata,time);
vs=-vs;

if z==1 %turn on 30% of max peak prominence for peak selection
pks_criteria=0.3*max(pks);
vs_criteria=0.3*max(vs);    
elseif z==2
    pks_criteria=0.50*max(pks);
vs_criteria=0.50*max(vs);
elseif z==3
    pks_criteria=avg_peaks;
    vs_criteria=avg_vs;
elseif z==4
    pks_criteria=0.70*max(pks);
vs_criteria=0.70*max(vs);
elseif z==5
    pks_criteria=0.95*max(pks);
vs_criteria=0.95*max(vs);
elseif z==6
    pks_criteria=0.97*max(pks);
vs_criteria=0.97*max(vs);
end


subplot(3,1,2)
title('Detrend Data')
plot(time, detrenddata); grid on;

% For calculating frequency. Use data without detrending to get more
% accurate peak counts
[pks_2 , pks_time_2,w_peaks_2]=findpeaks(data,time,'MinPeakProminence',pks_criteria);



[pks , pks_time,w_peaks]=findpeaks(detrenddata,time,'MinPeakProminence',pks_criteria);
%Need to have a peak prominence of at least 50% of the highest peak
%0.5*max(pks)-->Temporarilry substituted as avg_pks for now.
peaks=[pks_time;pks]; % Store indices of the peaks,time @ the indices, and the peak value
%from first row to the third row
avg_w_peaks=mean(w_peaks);

%deleted avg_w_peaks and threshold
[vs, vs_time,w_vs]=findpeaks(-detrenddata,time); 
%Need to have a peak prominence of at least 50% of the highest peak-->Temporarilry substituted as avg_vs for now
vs=-vs;
valleys=[vs_time;vs];

vs_new=[];
vs_time_new=[];
data_gap=max(detrenddata)-min(detrenddata);

for x=1:length(vs)
if vs(x)<=(mean(detrenddata))
%Minus 10% from the mean of the data as the threshold
vs_new=[vs_new vs(x)];
vs_time_new=[vs_time_new vs_time(x)];
end
end    

if length(vs_new)<=3 
vs=vs;
vs_time=vs_time;
else
vs=vs_new;
vs_time=vs_time_new;
end

smoothing_spline=fit(vs_time',vs','smoothingspline');

%Calculate avg_ampltidue
min_baseline=(smoothing_spline(pks_time))';
avgamp=mean(pks-min_baseline);
% %Find the theoretical 3 max values
[sort_amp,sort_loc]=sort(pks-min_baseline,'descend');

if length(sort_loc)>=3
max_loc=sort_loc(1:3);
max_amp=sort_amp(1:3);
else
max_loc=sort_loc(1:length(sort_loc));
max_amp=sort_amp(1:length(sort_loc));
end
avgamp=mean(max_amp);

%Find the amplitutde from the old peak detection
index_pk=[];
for i_3=1:length(pks_time_2)
index_pk(i_3)=find(time==pks_time_2(i_3));
end

%Plot local max,mins, and a pair of max and min that gives largest ampltiude
subplot(3,1,3)
hold on
title('Original Data with Minima and Maxima')
plot(time,detrenddata)
plot(pks_time,pks,'go',pks_time_2,detrenddata(index_pk),'ro');
plot(time,smoothing_spline(time));

if length(pks_time)<3
    pks_time=pks_time_2;
    pks=detrenddata(index_pk);
end
%Finding Frequency
%Using average time span from one peak to ther other

avg_frequency = length(pks_2)/(time(end)-time(1)); %workfromhere
avg_period=1/avg_frequency;
period=[diff(pks_time)];
avg_period=mean(period);
peak_diff=[diff(pks)];
avg_peak_diff=mean(peak_diff);

frequency=avg_frequency;

str=strcat('  Avg Amp of 3 Highest Peaks (in green circles)= ', num2str(avgamp),' ','  Highest Ampltiude =', num2str(max_amp), '  Avg Freqnuecy = ',num2str(avg_frequency));
suptitle(str)
