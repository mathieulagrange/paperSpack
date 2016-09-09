function [ output_args ] = starAck(fileName, displayType, pngFileName, monochrom)
%SPACK Summary of this function goes here
%   Detailed explanation goes here
addpath('rastamat');

if ~exist('displayType', 'var') || isempty(displayType), displayType = [1 2 3 4 5];displayType=4; end
if ~exist('monochrom', 'var'), monochrom = 0; end
if ~exist('pngFileName', 'var'), pngFileName = [];end%'../figures/duoFluteMono.png'; 
if ~exist('fileName', 'var'), fileName = '../sounds/churchBell.wav'; end

displayName = {'waveform', 'spectrum', 'spectrogram', 'spack', 'schack', 'smack' 'scack'};

fontSize = 18;

% load data
[s, sr] = wavread(fileName);
if ~isempty(regexp(fileName, 'einstein'))
 s=s(1:ceil(62.3*sr));   
end
% auditory spectrogram
hopTime = 0.001;

if size(s, 2) == 1 % mono
    [~, as, ps, asFrequency] = melfcc(s, sr, 'hoptime', hopTime, 'wintime', .025, 'nbands', 10);
    timeAxis = (1:size(ps, 2))*hopTime;
    frequencyAxis = (1:size(ps, 1))*sr/size(ps, 1)/2;
else
    [trackLength nbTracks] = size(s);
    
    wSize = 4096;
    wStep = 512;
    for t=1:nbTracks
        for i=0:ceil((trackLength-wSize)/wStep)
            as(i+1,t) = norm(s(i*wStep+1:min(trackLength, i*wStep+wSize), t));
        end
    end
    as = gaussianSmoothing(as', 60)';
    timeAxis = (1:size(as, 1))*wStep/sr;
end
% ps = ps .^ (.33);

%% display
for k=1:length(displayType)
    
    if monochrom == 1
        switch displayType(k)
            case  7
                colorPlot = ones(8, 3);
                colorPlot([1 5], :) = .3;
                colorPlot([2 6], :) = .6;
                colorPlot([4 8], :) = 0;
                
                colorMap = ones(7, 3);
                colorMap([1 7], :) = .3;
                colorMap([2 6], :) = .6;
                colorMap(4, :) = 0;
            otherwise
                colorMap = linspace(0, 1, size(as, 2))';
                colorMap = repmat(colorMap, 1, 3);
        end
        if displayType(k) == 3
            colorMap = 1-colorMap;
        end
        monoName = '_gray';
    elseif monochrom == 2
        monoName = '_bw';
        if displayType(k) == 5
            colorMap = ones(size(12, 2), 3);
            colorMap([2 4 7 9 11], :) = 0;
        elseif displayType(k) == 7
             colorPlot = ones(8, 3);
             colorMap = ones(7, 3);
        else
            colorMap = ones(size(as, 2), 3);
        end
    else
        switch displayType(k)
            case 4
                colorMap = blue2yellow(size(as, 1));
            case 5
                colorMap=[[1,0,0];...
            [0,0.5,1];...
            [1,1,0];...
            [0.5,0,1];...
            [0,1,0];...
            [1,0,0.5];...
            [0,1,1];...
            [1,0.5,0];...
            [0,0,1];...
            [0.5,1,0];...
            [1,0,1];...
            [0,1,0.5]];
            case 6
                colorMap = generateColormap(size(as, 2));
            case 7
                colorPlot = [[0 0 1];[.6 .6 1];[1 1 1];[0 0 0];[1 0 0];[1 .6 .6];[1 1 1];[0 0 0]];
                colorMap = [[1 0 0];[1 .6 .6];[1 1 1];[0 0 0];[1 1 1];[.6 .6 1];[0 0 1]];
            otherwise
                colorMap = colormap('jet');
        end
        monoName = '';
    end
    
    f = figure(displayType(k));
     if ~isempty(pngFileName)
        set(f, 'Visible', 'off');
     end
    clf
    hold on
    colormap(colorMap);
    switch displayType(k)
        case 1 % waveform
            plot((1:length(s))/sr, s, 'color', 'k');
        case 2 % spectrum
            sps = ps .^ (.33);
            sps=sps/max(sum(sps, 2))*max(abs(s));
            area(frequencyAxis, sum(sps, 2),'FaceColor', 'k');
        case 3 % spectrogram
            sps = ps .^ (.33);
            if monochrom == 2
                sps=sps/max(sum(sps, 2));
                th=.0002;
                sps(sps<th)=0;
                sps(sps>=th)=1;
            else
                sps=sps/max(sum(sps, 2))*max(abs(s));
            end
            
            imagesc(timeAxis, frequencyAxis, sps);
            axis xy
            ylim([0, 10000]);
            xlim([0 timeAxis(end)]);
            if monochrom<2
                colorbar;
            end
        case 4 % spack
            as = gaussianSmoothing(as, 80)';
%             as = as .^ (.8);
            as=as/max(sum(as, 2))*max(abs(s));
            
            if monochrom < 2
                h = area(timeAxis, as, 'EdgeColor', 'none', 'LineStyle','none');
                plot(timeAxis, sum(as, 2),'LineWidth', 1, 'color', 'k');
%                 colormap(colorMap);
            else
                h = area(timeAxis, as, 'EdgeColor', 'k', 'LineStyle',':');
                plot(timeAxis, sum(as(:, 1:ceil(end/3)), 2),'LineWidth', 1, 'color', 'k');
                plot(timeAxis, sum(as(:, 1:ceil(2*end/3)), 2),'LineWidth', 1, 'color', 'k');
                plot(timeAxis, sum(as, 2),'LineWidth', 1, 'color', 'k');
%                 colormap(ones(size(as, 1), 3));
            end
            if monochrom<2
                c = colorbar('location', 'westoutside', 'ytick', 1+.4+(0:size(as, 2))/(size(as, 2)+1)*size(as, 2), 'yticklabel', ceil(asFrequency(2:end-1)));
                set(c, 'Ticklength', [0 0])
            end
            set(gca,'YTick', [  ]);
        case 5 % schack
            cs = fft2chromamx((size(ps, 1)-1)*2, 12, sr)*ps;
            cs = gaussianSmoothing(cs, 60)';
            cs=cs/max(sum(cs, 2))*max(abs(s));
            cs=circshift(cs', -3)';           
            if monochrom < 2
                h = area(timeAxis, cs, 'EdgeColor', 'none', 'LineStyle','none');
                plot(timeAxis, sum(cs, 2),'LineWidth', 1, 'color', 'k');
            else
                h = area(timeAxis, cs, 'EdgeColor', 'k');
            end
            c= colorbar('location', 'westoutside', 'ytick', 1+.4+(0:12)/13*12, 'yticklabel', {'C', 'C#', 'D', 'Eb', 'E', 'F', 'F#', 'G', 'Ab', 'A', 'Bb', 'B'});
            set(c, 'Ticklength', [0 0])
            set(gca,'YTick', []);
        case 6 % smack
            [~, idse] = sort(sum(as, 1));
            h = area(timeAxis, as(:, idse), 'EdgeColor', 'k');
            sourceNames = {' rub', ' fan', ' steps', ' steps', ' bike', ' bell', ' ring', ' birds', ' traffic', ' childs'};
            c = colorbar('location', 'westoutside', 'fontsize', fontSize, 'ytick', 1+.4+(0:size(as, 2))/(size(as, 2)+1)*size(as, 2), 'yticklabel', sourceNames(idse));
            set(c, 'Ticklength', [0 0])
            set(gca,'YTick', []);
           
        case 7 % scack
            c = colorbar('location', 'westoutside', 'fontsize', fontSize, 'ytick', 1+.5+(0:7), 'yticklabel', {' rear left', ' front left', ' center', ' sub', ' center', ' front right', ' rear right'});
            set(c, 'Ticklength', [0 0]);
            cbfreeze(c);
            as(:, [3 4]) = as(:, [3 4])/2;
            channelOrder = {[6 2 3 4], [2 3 4], [3 4], [4], [4 3 1 5], [4 3 1], [4 3], [4]};
            for m=1:length(channelOrder)
                if m<5
                    h = area(timeAxis, sum(as(:, channelOrder{m}), 2), 'EdgeColor', 'k', 'FaceColor', colorPlot(m, :));
                else
                    h = area(timeAxis, -sum(as(:, channelOrder{m}), 2), 'EdgeColor', 'k', 'FaceColor', colorPlot(m, :));
                end
            end
            set(gca,'YTick', [  ]);
             
    end
    
    if displayType(k)==2
        xlabel('Frequency (Hz)', 'FontSize', fontSize);
    else
        xlabel('Time (s)', 'FontSize', fontSize);
    end
    if displayType(k)==3
        ylabel('Frequency (Hz)', 'FontSize', fontSize);
    else
            axis tight
            if all(displayType(k)~= [4 5 6 7])
        ylabel('Amplitude', 'FontSize', fontSize);
            end
    end
    set(gca, 'FontSize', fontSize);
 
    if ~isempty(pngFileName)
%         set(f, 'Visible', 'off');
         set(gca,'LooseInset', get(gca,'TightInset'));
        set(f, 'PaperPositionMode', 'auto');
%         set(f, 'Visible', 'off');
 set(f, 'Position', [0, 0, 800, 400]);

        print ('-dpng', '-r300', strrep(pngFileName, '.png', ['_' displayName{displayType(k)} monoName '.png']));
    end
end

% status = timeDomainVisualization (as', cmap, 2, 600, 1, ['../figures/' soundNames{soundId} '.png']);

function as = gaussianSmoothing(as, factor)

if ~exist('factor', 'var'), factor = 200; end

% gaussian filtering for smooth display
g = gausswin(ceil(size(as, 2)/factor)); % shall adapt the size to the length of the file
g = g/sum(g);
for k=1:size(as, 1)
    as(k, :) = conv(as(k, :), g, 'same');
end


