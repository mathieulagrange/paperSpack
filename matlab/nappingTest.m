

dataPath = '~/Dropbox/teaching15/data/instruments';

files = dir([dataPath '/*.wav']);

for k=1:length(files)
    starAck([dataPath '/' files(k).name], 1, [dataPath '/' files(k).name(1:end-3) 'png']);
end