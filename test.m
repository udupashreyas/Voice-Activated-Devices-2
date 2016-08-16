clear ; close all; clc
addpath('B:/References/Machine learning/Videos/mlclass-ex3');
addpath('../HMM2 (Digit Recognition)/VOICEBOX');

load( 'theta.mat' , 'all_theta');
comm = ['Bulb           ';'Tubelight      ';'Fan            ';'Television     ';'Air Conditioner';'Projector      ';'Laptop         ';'Cellphone      '];
com = cellstr(comm);

right = 0;
acc = 0;

for i = 1:8
    for j = 1:25
        fname = sprintf('../HMM3 (Word Recognition)/Test_Audio/num%dset%d.wav',i,j);
        x=wavread(fname);
        x=filter( [ 1 -0.9375 ], 1, x');
        data = melcepst(x,16000,'M',16,32,256,80);
        if(size(data)<200)
            data(size(data)+1:200,:) = zeros(200-size(data),16); 
        end
        data = data(1:200,:);
        data = data(:);
        data = [1 data'];
        score = data * all_theta';
        [y,n] = max(score);
        %disp(com{n});
        if(n==i)
            right = right + 1;
        else
            fprintf('%s recognised as %s\n',com{i},com{n});
        end
    end
end

acc = right / 200.0;
disp(right);
disp(acc);