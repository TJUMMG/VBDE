# Spatiotemporal Symmetric Convolutional Neural Network for Video Bit-Depth Enhancement  
Please notice that frames were **motion compensated** and were **normalized** by dividing 65535 before feeding into VBDE network. Only VBDE net was provided in our work. You can use your own MC algorithm to get motion compensated frames.

### VBDE Architecture  
<img src="https://github.com/TJUMMG/pictures2github/blob/master/Bit-Depth%20Enhancement/VBDE/vbde-architecture.png" width="80%" align=center />  


###  Result  
<img src="https://github.com/TJUMMG/pictures2github/blob/master/Bit-Depth%20Enhancement/VBDE/contrast.png" width="80%">  

### Config  
Set your own configuration like caffe path, model path, pretrained parameter path and result path in `main_VBDEnet_test_tmp16.m`. Please guarantee video frames were motion compensated before feeding into VBDE network.
### Test
For ‘Sintel’ test images,  run `main_VBDEnet_test_tmp16.m` to get 16-bit image. We provide four patches in MAT formats of one image that was motion compensated in 4bit_data folder, you can have a try directly with provided data without pre-processing.

### Cite

If you use this code, please cite the following publication:
    J.Liu, P.Liu, Y.Su, P.Jing, X.Yang, "Spatiotemporal Symmetric Convolutional Neural Network for Video Bit-Depth Enhancement", to appear in IEEE TRANSACTIONS ON MULTIMEDIA