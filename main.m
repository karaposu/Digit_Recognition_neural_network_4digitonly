clear all
clc
close all
%% includes for prerocessed data

load('mnist_all.mat')  %you might use the mist data or not use it at all .
load('net11.mat')     %this is my saved file for training. 
train_sample=100;   %number of the samples (per class) for training 



 
%% external files  ,include them here

extdataset1 = 'C:\Users\enesk\Desktop\w-s\nn-matlab\50piksel\28piksel\digit_dataset\1'; %
extdataset2 = 'C:\Users\enesk\Desktop\w-s\nn-matlab\50piksel\28piksel\digit_dataset\2'; %
extdataset3 = 'C:\Users\enesk\Desktop\w-s\nn-matlab\50piksel\28piksel\digit_dataset\3'; %
extdataset4 = 'C:\Users\enesk\Desktop\w-s\nn-matlab\50piksel\28piksel\digit_dataset\4'; %

files_1= dir(fullfile(extdataset1));
files_2= dir(fullfile(extdataset2));
files_3= dir(fullfile(extdataset3));
files_4= dir(fullfile(extdataset4));


for  i=3:52
expicset1{i-2}=imread(char(join( (extdataset1)+"\"+files_1(i).name ) ) );
expicset2{i-2}=  imread(char(join( (extdataset2)+"\"+files_2(i).name ) ) );
expicset3{i-2}=imread(char(join( (extdataset3)+"\"+files_3(i).name ) ) );
expicset4{i-2}=  imread(char(join( (extdataset4)+"\"+files_4(i).name ) ) );

end


% use this if  external images is not grayscale.(e.g jpg , png ...)
for  i=1:50
expicset1{i} =  rgb2gray(expicset1{i})   ;
expicset2{i} =  rgb2gray(expicset2{i})   ;
expicset3{i} =  rgb2gray(expicset3{i})   ;
expicset4{i} =  rgb2gray(expicset4{i})   ;
end

 
%vectorize images for training purpose  (1x784 is the size for each vectorized image)

 for t=1:50
 rft_picset1_data_array{t}= pic2vector( expicset1{t});
 rft_picset2_data_array{t}= pic2vector( expicset2{t});
 rft_picset3_data_array{t}= pic2vector( expicset3{t});
 rft_picset4_data_array{t}= pic2vector( expicset4{t});
end

   %now for training we need all images in the same matrix.  
   %for each class we are creating  (50x784) sized matrix .
   %we will merge the classes later : )  no worries 
  for t=1:50
 rftx_picset1_data_array(t,:)=rft_picset1_data_array{t}   ;
 rftx_picset2_data_array(t,:)= rft_picset2_data_array{t};
 rftx_picset3_data_array(t,:)=rft_picset3_data_array{t};
 rftx_picset4_data_array(t,:)= rft_picset4_data_array{t};       
          
  end

  %i am using mnist images too so i merge same classes here.. 
   train1 =[ rftx_picset1_data_array  ; train1];
     train2 =[ rftx_picset2_data_array  ; train2];
       train3 =[ rftx_picset3_data_array  ; train3];
         train4 =[ rftx_picset4_data_array  ; train4];
         

%% main program for non-trained data 

for i=1:train_sample
pic1set(i,:)=train1(i,:);
pic2set(i,:)=train2(i,:);
pic3set(i,:)=train3(i,:);
pic4set(i,:)=train4(i,:);

end


%this is where you can plot your dataset elements
%rememeber always see it with your eyes..

figure(3)
for i = 1:10      
   pics=pic1set(i,:);  
   pics= test_sample2pic(pics);
   subplot(5,2,i)      ;                       
   imshow(pics);
    
end

figure(5)
for i = 1:10      
   pics=pic2set(i,:);  
   pics= test_sample2pic(pics);
    subplot(5,2,i)                              % plot them in 6 x 6 grid
    imshow(pics)
                           % show the image
                    % show the label
end


%we need our data with 784x50 format.  

pic1set=pic1set' ;
pic2set=pic2set' ;
pic3set=pic3set' ;
pic4set=pic4set' ;


%we need our data to as a binary .. we dont need colors 
 
pic1set=binary_convertor(pic1set);
pic2set=binary_convertor(pic2set);
pic3set=binary_convertor(pic3set);
pic4set=binary_convertor(pic4set);

%here we are . All training data in 1 matrix
all_data_here=[pic1set pic2set  pic3set pic4set  ];


%lets create target matrix. 
v=[ 1 1 1 1  ];
v=diag(v);



u1=repmat(v(:,1),1,train_sample);
u2=repmat(v(:,2),1,train_sample);
u3=repmat(v(:,3),1,train_sample);
u4=repmat(v(:,4),1,train_sample);


%this is our target matrix ..
train_target=[ u1 u2 u3 u4]; 



%% TRAINING SECTION 

net=patternnet(25);
net.layers{1}.transferFcn='tansig';
net.trainFcn='traingd';
net.performFcn='mse';
net.trainParam.epochs=10000;
%This command starts training... it took 5 min for me( 100 sample for each
%class)
net = train(net,all_data_here,train_target);

%Down below are settings for network . You can try various things. 
%feel free to meddle with anything.

% %trainFcn = 'trainscg';                         
% trainFcn = 'trainbr';
% hiddenLayerSize = [80 20];  
% hiddenLayerSize = 10; 
% net = patternnet(hiddenLayerSize);              
% %net = feedforwardnet (hiddenLayerSize)
% net.trainParam.max_fail = 6;
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% net.performFcn = 'crossentropy';
% net.performFcn = 'mse';
% net.performFcn = 'traingd';
% 
% net.trainParam.min_grad= 1e-10 ;
% [net,tr] = train(net,all_data_here,train_target);
% net.trainParam.lr = 0.1;
% net.divideParam.trainRatio = 80/100;
% net.divideParam.valRatio = 5/100;
% net.divideParam.testRatio = 15/100;


% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. NFTOOL falls back to this in low memory situations.
%trainFcn = 'trainbr';  % Bayesian Regularization
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% %TRAINING PARAMETERS
% net.trainParam.show=50;  %# of ephocs in display
% net.trainParam.lr=0.05;  %learning rate
% net.trainParam.epochs=10000;  %max epochs
% net.trainParam.goal=0.05^2;  %training goal
%net = feedforwardnet (hiddenLayerSize,trainFcn);
%net=feedforwardnet([100  50] );
%try trainoss
%net=feedforwardnet(100);
% net.layers{1}.transferFcn='logsig';
% net.layers{2}.transferFcn='logsig';
%mlp.layers{3}.transferFcn='tansig';
% net.trainParam.min_grad= 1e-10 ;
% net.trainParam.showWindow=true;
% net.trainParam.time=inf;
% net.trainParam.goal=0;


%% This section is for testing with external images.
%You can drew images in paint and paste the folder to the  "test_folder"
%i used 4 images only.So simply put more variable if you want to test more



test_folder = 'C:\Users\enesk\Desktop\w-s\nn-matlab\50piksel\28piksel'; % folder with big images


files_t= dir(fullfile(test_folder));  %list files here

test_images{1}=imread(char(join( (test_folder)+"\"+files_t(3).name ) ) );
test_images{2}=imread(char(join( (test_folder)+"\"+files_t(4).name ) ) );
test_images{3}=imread(char(join( (test_folder)+"\"+files_t(5).name ) ) );
test_images{4}=imread(char(join( (test_folder)+"\"+files_t(6).name ) ) );


%lets delete third dimension from our precise images .. 

test_images{1} = rgb2gray(test_images{1})   
test_images{2} = rgb2gray(test_images{2}) 
test_images{3} = rgb2gray(test_images{3}) 
test_images{4} = rgb2gray(test_images{4}) 


%now lets convert them to binary because why not !

test_images{1}=binary_convertor(test_images{1});
test_images{2}=binary_convertor(test_images{2});
test_images{3}=binary_convertor(test_images{3});
test_images{4}=binary_convertor(test_images{4});
figure(5)

%always see your data set , always...
for b=1:4
subplot(4,1,b)
    imshow(  test_images{b}  )
 
end


%now vectorize them  and do other neccessary stuff

s=row_and_col_values_of_img (test_images{1})  ;
s2=row_and_col_values_of_img (test_images{2})  ;
s3=row_and_col_values_of_img (test_images{3})  ;
s4=row_and_col_values_of_img (test_images{4})  ;

s=s';
s2=s2';
s3=s3';
s4=s4';

net(s)
net(s2)
net(s3)
net(s4)

  print_result_array_target( net(s) )
  print_result_array_target( net(s2) )
  print_result_array_target( net(s3) )
  print_result_array_target( net(s4) )


  %% internal test which uses mnist test data .
  vv=test1(1,:)
    vv2=test2(2,:)
      vv3=test3(3,:)
        vv4=test4(4,:)
        
        ready_test_data_array={vv vv2 vv3 vv4}
        
        
        for t=1:4   % binary
         ready_test_data_array{t}=binary_convertor(ready_test_data_array{t});
        end
        
        for t=1:4   % data2pic we must see them first !
          ready_test_pic_array{t}=test_sample2pic( ready_test_data_array{t});
        end
        
        figure(7)
        for t=1:4
        subplot(4,1,t)
           imshow(ready_test_pic_array{t})
        end


       for t=1:4
          e= ready_test_data_array{t}
          ready_test_data_array{t}=e';
       end


       
       for t=1:4
          e= ready_test_data_array{t};
          net(e)
       end 
        
         
       for t=1:4
          e= ready_test_data_array{t};
          print_result_array_target( net(e) );
       end 
       
       %% if you want to use white background for your images 
       
       %You can make use of these codes
       % test_image = reshape(M(:,:,1),[784,1]); % greyscale image of size 784x1
      % test_image = abs(test_nr-255)/255; % negative of this image
        
       