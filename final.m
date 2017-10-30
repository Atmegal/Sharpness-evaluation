function [re] = final( img1 )

%This is the Matlab code of a simple algorithm for calculating the
%sharpness for an input image.
%Please refer to the following papers if you use this code for your research:

%Y. Zhan, and R. Zhang, ¡°No-Reference Image Sharpness Assessment 
%Based on the Maximum Gradient and the Variability of Gradients¡±,
%IEEE Transaction on Multimedia, 2017.

%Kindly report any suggestions or corrections to zrong@ustc.edu.cn

%Input :  the input image (gray image)
%Output:  the sharpness evaluation

F1 = [0 0; -1 1];
F2 = F1';
    
H1 = conv2(img1, F1, 'valid');
H2 = conv2(img1, F2, 'valid');
g = sqrt(H1.^2+H2.^2);  
  
[row col]= size(g);
B = round(min(row, col)/16);
g_center  = g(B+1:end-B, B+1:end-B); %used from LPC_SI

MaxG = max(g_center(:));
MinG = min(g_center(:)); 
CVG = (MaxG-MinG)./mean2(g_center); 
   
%varG = std(g_center(:));
%varG1 = std(img1(:));
%CVG = varG./mean2(g_center);

re = MaxG.^0.61.*CVG.^0.39;
end

