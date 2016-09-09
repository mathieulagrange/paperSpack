function generateFigures(soundId, displayType, monochrom)

if nargin==0
    generateFigures([11 2], [4], 0); % color
%     generateFigures([], [], 1); % gray
%     generateFigures([], [], 2); % bw
end

addpath('rastamat');
imagePath = '../figures/starAck/';
soundPath = '../sounds/';
soundNames = {'dogBark', 'songBird', 'foghorn', 'churchBell', 'motorcycle', 'ringTone', 'loveyou', 'sheLovesMe', 'mars', 'extraitbach', 'einstein', 'fluteGammeMonoNorm', 'duoFluteMono'};

if ~exist('soundId', 'var') || isempty(soundId), soundId = 1:length(soundNames); end

if ~exist('displayType', 'var') || isempty(displayType), displayType = [1 2 3 4 5]; end
if ~exist('monochrom', 'var'), monochrom = 0; end

% soundId = soundId([4]);
for k=1:length(soundId)
    fileName = [soundPath soundNames{soundId(k)} '.wav'];
    pngFileName = [imagePath soundNames{soundId(k)} '.png'];
    starAck(fileName, displayType, pngFileName, monochrom);
end

 return

fileName = [soundPath  'Multisource.wav'];
pngFileName = [imagePath 'Multisource.png'];
starAck(fileName, 6, pngFileName, monochrom);

fileName = [soundPath  '51SceneSynth.wav'];
pngFileName = [imagePath  '51SceneSynth.png'];
 starAck(fileName, 7, pngFileName, monochrom);