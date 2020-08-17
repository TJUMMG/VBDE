# Spatiotemporal Symmetric Convolutional Neural Network for Video Bit-Depth Enhancement  
Please notice that frames were **motion compensated** and were **normalized** by dividing 65535 before feeding into VBDE network. Only VBDE net was provided in our work. You can use your own MC algorithm to get motion compensated frames.

### VBDE Architecture  
<img src="https://github.com/TJUMMG/pictures2github/blob/master/Bit-Depth%20Enhancement/VBDE/vbde-architecture.png" width="80%" align=center />  


###  Result  
<img src="https://github.com/TJUMMG/pictures2github/blob/master/Bit-Depth%20Enhancement/VBDE/contrast.png" width="80%">  

### Config  
You need to set model path, pretrained parameter path and result path in `main_VBDEnet_test_tmp16.m`. Please guarantee video frames were motion compensated before feeding into VBDE network.
### Test
<<<<<<< HEAD
For ‘Sintel’ test images,  run `main_VSRnet_test_tmp16.m` to get 16-bit image. We provide four patches in MAT formats of one image that was motion compensated in 4bit_data folder, you can have a try directly with provided data without pre-processing.
=======
For ‘Sintel’ test images,  run `main_VBDEnet_test_tmp16.m` to get 16-bit image.
>>>>>>> 9308d8983cd3975c89168acc807d3082078c23a8
