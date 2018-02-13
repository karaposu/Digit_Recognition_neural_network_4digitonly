
clear all
clc
close all
%% initialize data

load('mnist_all.mat')

% Initilization

% target = diag(v);

bias1 = randn(1);
bias2 = randn(1);

%size
sz0 = size(train0);    %5923x784
sz0 = sz0(1);
sz1 = size(train1);
sz1 = sz1(1);


for i=1:4000
pic1set(i,:)=train1(i,:);
end

for i=1:4000
pic2set(i,:)=train2(i,:);
end


pic1set=pic1set' ;
pic2set=pic2set' ;


pic1set=binary_convertor(pic1set);

pic2set=binary_convertor(pic2set);


all_data_here=[pic1set pic2set];

train_target=[ zeros(1,4000)  ones(1,4000)];

  %  test = diag(test);
% c=[ zeros(1,4000) ones(1,4000)  ;  ones(1,4000)  zeros(1,4000) ]
%% mlp

% mlp manuel 

mlp=feedforwardnet([200 ]);

mlp.layers{1}.transferFcn='tansig';
mlp.layers{2}.transferFcn='tansig';
%mlp.layers{3}.transferFcn='tansig';

mlp.trainFcn='traingd';
mlp.performFcn='mse';
mlp.trainParam.min_grad= 1e-10 ;
mlp.trainParam.showWindow=true;
mlp.trainParam.epochs=10000;
mlp.trainParam.time=inf;
mlp.trainParam.goal=0;

view(mlp)
 mlp = train(mlp,all_data_here,train_target);
save mlp
%save 'C:\Users\acer\Desktop\Digit Recognition\data_epoc200.mat'
save(mlp, 'net')

%
%% test data
% 
% my_dataset = 'c:/whatever';
% load(my_dataset);

test_folder = 'C:\Users\enesk\Desktop\w-s\nn-matlab\50piksel\28piksel'; % folder with big images


files_t= dir(fullfile(test_folder));

test_images{1}=imread(char(join( (test_folder)+"\"+files_t(8).name ) ) );
test_images{2}=imread(char(join( (test_folder)+"\"+files_t(9).name ) ) );
test_images{3}=imread(char(join( (test_folder)+"\"+files_t(10).name ) ) );
test_images{4}=imread(char(join( (test_folder)+"\"+files_t(11).name ) ) );




test_images{1}=binary_convertor(test_images{1});
test_images{2}=binary_convertor(test_images{2});
test_images{3}=binary_convertor(test_images{3});
test_images{4}=binary_convertor(test_images{4});
figure('Name','Yatay Veri Seti')
for b=1:4
subplot(2,2,b)
    imshow(  test_images{b}  )
 
end

test_pic_data= row_and_col_values_of_img (test_images{1})  ;
test_pic_data2= row_and_col_values_of_img (test_images{2})  ;
test_pic_data3= row_and_col_values_of_img (test_images{3})  ;
test_pic_data4= row_and_col_values_of_img (test_images{4})  ;

s=row_and_col_values_of_img (test_images{1})  ;
s2=row_and_col_values_of_img (test_images{2})  ;
s3=row_and_col_values_of_img (test_images{3})  ;
s4=row_and_col_values_of_img (test_images{4})  ;

s=s';
s2=s2';
s3=s3';
s4=s4';
 print_result( mlp(s) )
  print_result( mlp(s2) )
   print_result( mlp(s3) )
  print_result( mlp(s4) )


