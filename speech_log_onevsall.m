clear ; close all; clc
addpath('../VOICEBOX');
num_labels = 8;

for i=1:8
    for j=1:40
        fname = sprintf('../HMM3 (Word Recognition)/Train_Audio/num%dset%d.wav',i,j);
        x=wavread(fname);
        x=filter( [ 1 -0.9375 ], 1, x');
        data = melcepst(x,16000,'M',16,32,256,80);
        if(size(data)<200)
            data(size(data)+1:200,:) = zeros(200-size(data),16); 
        end
        data = data(1:200,:);
        data = data(:);
        fin((40*(i-1)+j),:) = data';
    end
end
y = [ones(40,1);ones(40,1)*2;ones(40,1)*3;ones(40,1)*4;ones(40,1)*5;ones(40,1)*6;ones(40,1)*7;ones(40,1)*8];
fprintf('\nTraining One-vs-All Logistic Regression...\n')
lambda = 0.1;
[all_theta] = oneVsAll(fin, y, num_labels, lambda);
% pred = predictOneVsAll(all_theta, fin);
% fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

save( 'theta_dep.mat' , 'all_theta');