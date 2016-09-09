function status = timeDomainVisualization (tracks, cmap, figNum, maxWidth, lineThickness, fileName)

nbTracks = size(tracks,1);
trackLength = length(tracks(1,:));

% Producing a time domain visualization
% wSize = 8192;
% wStep = 512;
% for t=1:nbTracks
%     for i=0:ceil((trackLength-wSize)/wStep)
%         % Not really power, but more nicely additive, better suited for
%         % this representation I think
%         powers(i+1,t) = norm(tracks(t,i*wStep+1:min(trackLength, i*wStep+wSize)));
%     end
% end
% 
% powers(powers<max(powers(:))/500) = 0;

powers = tracks;


% Screen res is ~90dpi, print res is 150dpi, hence the " /1.6 "
imgWidth = min(maxWidth, 2*size(powers,1)) / 1.6;

% Displayed version
f=figure(figNum);
clf;
% h=area(powers,'LineWidth', lineThickness/1.6, 'EdgeColor', [.3, .3, .3]);
hold on
h = area(powers, 'EdgeColor', 'none', 'LineStyle','none');



plot(sum(powers, 2),'LineWidth', lineThickness/1.6, 'color', 'k')
set(gca,'YTick', []);
% set(f, 'Position', [0, 0, imgWidth, 400]);
colormap(cmap);

% Version saved to graphic file
f = figure(1000);
clf;
% h = area(powers,'LineWidth', lineThickness/1.6, 'EdgeColor', [.3, .3, .3]);
set(gca,'YTick', []);
colormap(cmap);
set(f, 'Visible', 'off');
set(f, 'Position', [0, 0, imgWidth, 400]);
set(f, 'PaperPositionMode', 'auto');
print ('-dpng', '-r150', fileName);

status = 1;

end
