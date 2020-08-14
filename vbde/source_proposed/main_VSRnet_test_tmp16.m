clear; close all;
clearvars
%% GENERAL PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CAFFEPATH = '/home/lab330/users/rachel/DSLT/caffe1';   % path to caffe installation
                        
USE_GPU = true;         % set to false, if no GPU available -> slowest
GPU_ID = 0;             % GPU ID -> should normally be 0 

addpath([CAFFEPATH '/matlab'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%patch_num=80;
patch_num=200;
im_test_num=patch_num/4;
t=0;


for k=1:3

caffe.reset_all();

if USE_GPU
  caffe.set_mode_gpu();
  caffe.set_device(GPU_ID);
else
  caffe.set_mode_cpu();
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%result_path=['/home/lab330/users/lpp/vbde/vbde_caffe/VSR_lpp/VSRnet_source/test_result/test_data2/test_1_20/' num2str(k) '/im_sr/im_SR'];
result_data_path=['../test_result/data_50/proposed/' num2str(k) '/data_sr/data_SR'];
model_def_file = '/home/lab330/users/lpp_zhengli/source_proposed/model/test_proposed.prototxt';
model_file =  ['/home/lab330/users/lpp_zhengli/source_proposed/model/snapshot/train_iter_160000.caffemodel'];


net = caffe.Net(model_def_file, model_file, 'test');
%% do forward pass



%output = zeros(size(im_bic,2),size(im_bic,1),size(im_bic,3),size(im_bic,4));
for imgIdx = 1:patch_num
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    PRED_PATH_new = ['../test_data/data_50/pred_cut' num2str(k) '_256/pred_data_cut' num2str(imgIdx)];
    %%PRED_PATH_new = ['/home/lab330/users/lpp/vbde/vbde_caffe/VSR_lpp/select1009/10_data2/color_testdata/pred_cut' num2str(k) '_256/pred_data_cut' num2str(imgIdx)];
    %%PRED_PATH_new = ['/home/d330/lpp/study/VSR_lpp/VSRnet_data_0/test_cut256/pred_data_cut' num2str(imgIdx)];
    load(PRED_PATH_new,'pred_data_cut');
    tic
    tmp = net.forward({pred_data_cut});
    toc;
    t=t+toc;
    im_SR = tmp{1};  
    %result_path_i=[result_path num2str(imgIdx) '.png'];    
    result_data_i=[result_data_path num2str(imgIdx) '.mat'];   
    %SE(imgIdx)=sum(sum((im_SR-pred_data_cut(:,:,6)).^2));
    im_SR_16 = uint16(permute(im_SR,[2 1 3])*65535);
    save(result_data_i,'im_SR_16');
end

fprintf('----------------\n');

end
t_mean=t/im_test_num
caffe.reset_all();

%%%%%%%%%%%%%%%%%%%cat pictures

result_path={'../test_result/data_50/proposed/1/data_sr/data_SR','../test_result/data_50/proposed/2/data_sr/data_SR','../test_result/data_50/proposed/3/data_sr/data_SR'};
result_path_big='../test_result/data_50/proposed/im_generate';

%%for im_num=0:99
for im_num=1:im_test_num

for k=1:3
    data_num=1;
for imgIdx = (im_num*4-3):(im_num*4)
    result_path_i=[result_path{k} num2str(imgIdx) '.mat']; 
    load(result_path_i);
    pacth{data_num}=im_SR_16;
    data_num=data_num+1;
    if data_num > 4
        output(:,:,k) = cat(2, pacth{1}, pacth{2}, pacth{3}, pacth{4});
        data_num=1;
    end

end
end

    big_path = [result_path_big '/im_ge' num2str(im_num) '.png']; 
    imwrite(output ,big_path);
end

