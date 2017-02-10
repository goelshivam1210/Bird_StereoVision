% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 724.555523991175846 ; 738.740665919190064 ];

%-- Principal point:
cc = [ 347.531278977898637 ; 244.283500914498944 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.149094676370825 ; -0.628421048687531 ; 0.020608262495589 ; 0.002468327871880 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 70.800179180668152 ; 73.387720113307367 ];

%-- Principal point uncertainty:
cc_error = [ 35.676814943930665 ; 42.803439108490103 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.168711387506546 ; 0.885582482114992 ; 0.022329480167792 ; 0.021874358483489 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 14;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.089720e+00 ; 1.911647e+00 ; -2.779801e-01 ];
Tc_1  = [ 5.757165e+01 ; -1.725628e+02 ; 1.105224e+03 ];
omc_error_1 = [ 4.571067e-02 ; 4.497566e-02 ; 7.979832e-02 ];
Tc_error_1  = [ 5.509297e+01 ; 6.317528e+01 ; 1.020637e+02 ];

%-- Image #2:
omc_2 = [ 2.057364e+00 ; 1.934265e+00 ; -3.630356e-01 ];
Tc_2  = [ 4.561277e+01 ; -1.561611e+02 ; 1.282639e+03 ];
omc_error_2 = [ 4.400827e-02 ; 4.768338e-02 ; 8.101270e-02 ];
Tc_error_2  = [ 6.381692e+01 ; 7.340179e+01 ; 1.164365e+02 ];

%-- Image #3:
omc_3 = [ 2.053361e+00 ; 1.938317e+00 ; -3.570052e-01 ];
Tc_3  = [ 5.210081e+01 ; -1.619614e+02 ; 1.271035e+03 ];
omc_error_3 = [ 4.405480e-02 ; 4.761165e-02 ; 8.092271e-02 ];
Tc_error_3  = [ 6.328440e+01 ; 7.272114e+01 ; 1.154829e+02 ];

%-- Image #4:
omc_4 = [ 2.123389e+00 ; 1.947759e+00 ; -1.865562e-01 ];
Tc_4  = [ 7.394492e+01 ; -2.275579e+02 ; 1.043768e+03 ];
omc_error_4 = [ 4.879715e-02 ; 4.438432e-02 ; 8.319503e-02 ];
Tc_error_4  = [ 5.225708e+01 ; 5.968169e+01 ; 9.951688e+01 ];

%-- Image #5:
omc_5 = [ 2.103858e+00 ; 1.982679e+00 ; 1.981080e-02 ];
Tc_5  = [ 1.514048e+02 ; -1.966075e+02 ; 1.014386e+03 ];
omc_error_5 = [ 5.247374e-02 ; 3.805887e-02 ; 8.678083e-02 ];
Tc_error_5  = [ 4.997861e+01 ; 5.853080e+01 ; 1.014817e+02 ];

%-- Image #6:
omc_6 = [ 2.140304e+00 ; 1.971932e+00 ; -9.314968e-02 ];
Tc_6  = [ 3.326300e+01 ; -1.908393e+02 ; 1.016479e+03 ];
omc_error_6 = [ 4.541127e-02 ; 4.049271e-02 ; 8.122379e-02 ];
Tc_error_6  = [ 5.045781e+01 ; 5.812579e+01 ; 9.927281e+01 ];

%-- Image #7:
omc_7 = [ 1.938802e+00 ; 1.894346e+00 ; 1.834373e-01 ];
Tc_7  = [ -1.687060e+02 ; -1.563241e+02 ; 1.109954e+03 ];
omc_error_7 = [ 4.167912e-02 ; 3.689353e-02 ; 6.748892e-02 ];
Tc_error_7  = [ 5.586630e+01 ; 6.421392e+01 ; 1.145224e+02 ];

%-- Image #8:
omc_8 = [ -2.184866e+00 ; -2.147250e+00 ; -4.778391e-01 ];
Tc_8  = [ 1.258105e+02 ; -2.291563e+02 ; 1.010909e+03 ];
omc_error_8 = [ 3.603745e-02 ; 5.728033e-02 ; 9.585889e-02 ];
Tc_error_8  = [ 4.980280e+01 ; 5.848358e+01 ; 9.812948e+01 ];

%-- Image #9:
omc_9 = [ 1.908331e+00 ; 1.785161e+00 ; -5.221316e-01 ];
Tc_9  = [ 9.753761e+01 ; -1.584679e+02 ; 1.175765e+03 ];
omc_error_9 = [ 4.461751e-02 ; 4.918913e-02 ; 7.447202e-02 ];
Tc_error_9  = [ 5.918193e+01 ; 6.743187e+01 ; 1.004592e+02 ];

%-- Image #10:
omc_10 = [ 1.742025e+00 ; 1.662760e+00 ; 4.197418e-01 ];
Tc_10  = [ -9.042910e+01 ; -1.380192e+02 ; 1.103750e+03 ];
omc_error_10 = [ 4.439066e-02 ; 3.499702e-02 ; 6.292040e-02 ];
Tc_error_10  = [ 5.525695e+01 ; 6.375097e+01 ; 1.145793e+02 ];

%-- Image #11:
omc_11 = [ 1.834832e+00 ; 1.697802e+00 ; 4.028725e-01 ];
Tc_11  = [ -1.079526e+02 ; -1.341193e+02 ; 1.104025e+03 ];
omc_error_11 = [ 4.435456e-02 ; 3.332605e-02 ; 6.391273e-02 ];
Tc_error_11  = [ 5.538103e+01 ; 6.382953e+01 ; 1.149549e+02 ];

%-- Image #12:
omc_12 = [ 1.985642e+00 ; 1.867663e+00 ; 7.801270e-02 ];
Tc_12  = [ -1.318838e+02 ; -1.389998e+02 ; 1.093584e+03 ];
omc_error_12 = [ 4.075343e-02 ; 3.708386e-02 ; 6.755122e-02 ];
Tc_error_12  = [ 5.457914e+01 ; 6.300642e+01 ; 1.103967e+02 ];

%-- Image #13:
omc_13 = [ 2.121410e+00 ; 1.910516e+00 ; -1.881012e-01 ];
Tc_13  = [ 1.303225e+02 ; -9.788969e+01 ; 1.075509e+03 ];
omc_error_13 = [ 5.169786e-02 ; 3.955216e-02 ; 8.636249e-02 ];
Tc_error_13  = [ 5.274221e+01 ; 6.196817e+01 ; 1.033595e+02 ];

%-- Image #14:
omc_14 = [ 2.106795e+00 ; 1.878646e+00 ; -2.401693e-01 ];
Tc_14  = [ 1.274140e+02 ; -1.156709e+02 ; 1.082507e+03 ];
omc_error_14 = [ 5.120786e-02 ; 4.172723e-02 ; 8.333494e-02 ];
Tc_error_14  = [ 5.348252e+01 ; 6.230486e+01 ; 1.013428e+02 ];

