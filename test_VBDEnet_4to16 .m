clear; close all;
clearvars
%% GENERAL PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CAFFEPATH = '/home/lab330/users/rachel/DSLT/caffe1';   % path to caffe installation
                        
USE_GPU = true;         % set to false, if no GPU available -> slowest
GPU_ID = 0;             % GPU ID -> should normally be 0 

addpath([CAFFEPATH '/matlab'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
patch_num=200;      % patch numbers for total test images
im_test_num=patch_num/4;     % numbers of test images
t=0;



caffe.reset_all();

if USE_GPU
  caffe.set_mode_gpu();
  caffe.set_device(GPU_ID);
else
  caffe.set_mode_cpu();
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
result_data_path=['/home/lab330/users/LiuPingping/vbde/VBDE_formal/GrayTest/test1021/'];
if ~exist(result_data_path,'dir')
    mkdir(result_data_path);
end
model_def_file = '/home/lab330/users/LiuPingping/vbde/VBDE_formal/GrayTest/model/test_proposed.prototxt';
model_file =  ['/home/lab330/users/LiuPingping/vbde/YZW/source_proposed/model/snapshot/train_iter_160000.caffemodel'];


net = caffe.Net(model_def_file, model_file, 'test');
% do forward pass
for imgIdx = 1:patch_num
for channel = 1:3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    PRED_PATH_new = ['/media/lab330/My Passport/lpp/lpp_zhengli/vbde_mc_data&results/test_data/data_50/pred_cut' num2str(channel) '_256/pred_data_cut' num2str(imgIdx)];
    load(PRED_PATH_new,'pred_data_cut');
    tic
    tmp = net.forward({pred_data_cut});
    toc;
    t=t+toc;
    im_SR = tmp{1};      
    result_data_i=[result_data_path num2str(imgIdx) '.mat'];
    if channel == 1
    im_SR_16_1 = uint16(permute(im_SR,[2 1 3])*65535);
    elseif channel ==2
        im_SR_16_2 = uint16(permute(im_SR,[2 1 3])*65535);
    else
        im_SR_16_3 = uint16(permute(im_SR,[2 1 3])*65535);
    end
    
end
    im_SR_16 = cat(3, im_SR_16_1,im_SR_16_2,im_SR_16_3);
    save(result_data_i,'im_SR_16');
end
fprintf('----------------\n');

t_mean=t/im_test_num
caffe.reset_all();

%%%%%%%%%%%%%%%%%%%cat pictures

result_path='./test1021/';     % directory to save mat files

result_path_image='./test_data/';     % directory to save pictures 
if ~exist(result_path,'dir')
    mkdir(result_path);
end

for im_num=1:im_test_num

    data_num=1;
for imgIdx = (im_num*4-3):(im_num*4)
    result_path_i=[result_path num2str(imgIdx) '.mat']; 
    load(result_path_i);
    pacth{data_num}=im_SR_16;
    data_num=data_num+1;
    if data_num > 4
        output(:,:,:) = cat(2, pacth{1}, pacth{2}, pacth{3}, pacth{4});
        data_num=1;
    end

end

    image_path = [result_path_image '/im_ge' num2str(im_num) '.png']; % image name
    imwrite(output, image_path);
end

