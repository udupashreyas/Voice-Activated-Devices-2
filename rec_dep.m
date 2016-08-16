clear ; close all; clc
addpath('../VOICEBOX');

load( 'theta_dep.mat' , 'all_theta');
comm = ['Bulb           ';'Tubelight      ';'Fan            ';'Television     ';'Air Conditioner';'Projector      ';'Laptop         ';'Cellphone      '];
com = cellstr(comm);

ard1 = serial('COM15','BaudRate',9600);
fopen(ard1);

while(1)
    %fprintf('Program paused. Press enter to continue.\n');
    %pause;
    recObj = audiorecorder;
    prompt = sprintf('Say keyword\n');
    disp(prompt);
    recordblocking(recObj,5);
    y = getaudiodata(recObj);
    y(y==0) = [];

    x=filter( [ 1 -0.9375 ], 1, y');
    data = melcepst(x,16000,'M',16,32,256,80);
    if(size(data)<200)
        data(size(data)+1:200,:) = zeros(200-size(data),16); 
    end
    data = data(1:200,:);
    data = data(:);
    data = [1 data'];

    score = data * all_theta';
    [y,i] = max(score);
    disp(com{i});
    pause(2);
    fprintf(ard1,'%d',round(i));
end