# Spatiotemporal Symmetric Convolutional Neural Network for Video Bit-Depth Enhancement  
Please notice that frames were **motion compensated** before feeding into VBDE network. Only VBDE net was provided in our work. 
You can use your own MC algorithm to get motion compensated frames before feeding them into the network.  
### VBDE Architecture  
<img src="https://github.com/TJUMMG/pictures2github/blob/master/Bit-Depth%20Enhancement/VBDE/vbde-architecture.png" width="80%" align=center />  
### Results  
<img src="https://github.com/TJUMMG/pictures2github/blob/master/Bit-Depth%20Enhancement/VBDE/contrast.png" width="50%">  

### Config  
You need to set model path, pretrained parameter path and result path in `main_VBDEnet_test_tmp16.m`. Please guarantee video frames were motion compensated before feeding into VBDE network.
### Test
For ‘Sintel’ test images,  run `main_VSRnet_test_tmp16.m` to get 16-bit image.
