% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 630.248598560084133 ; 625.579644699877804 ];

%-- Principal point:
cc = [ 283.560416706054070 ; 200.578690191565471 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.251533042735421 ; -0.774227667065317 ; -0.013498149326779 ; 0.000066317847425 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 42.318732551898137 ; 42.922897766657357 ];

%-- Principal point uncertainty:
cc_error = [ 28.785227418398794 ; 26.088892873283786 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.118550314954674 ; 0.518157663926393 ; 0.018520878464609 ; 0.023835665500317 ; 0.000000000000000 ];

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
omc_1 = [ 2.134256e+00 ; 1.939890e+00 ; -4.142837e-01 ];
Tc_1  = [ -1.968258e+02 ; -9.588392e+01 ; 9.911926e+02 ];
omc_error_1 = [ 3.100538e-02 ; 4.202396e-02 ; 5.325157e-02 ];
Tc_error_1  = [ 4.506792e+01 ; 4.151651e+01 ; 6.476116e+01 ];

%-- Image #2:
omc_2 = [ 2.112764e+00 ; 1.968230e+00 ; -5.567671e-01 ];
Tc_2  = [ -1.823394e+02 ; -6.614409e+01 ; 1.145820e+03 ];
omc_error_2 = [ 3.021859e-02 ; 4.458059e-02 ; 5.509960e-02 ];
Tc_error_2  = [ 5.200993e+01 ; 4.791963e+01 ; 7.392872e+01 ];

%-- Image #3:
omc_3 = [ 2.111605e+00 ; 1.978734e+00 ; -5.460227e-01 ];
Tc_3  = [ -1.777166e+02 ; -7.343497e+01 ; 1.135962e+03 ];
omc_error_3 = [ 3.023443e-02 ; 4.452643e-02 ; 5.514731e-02 ];
Tc_error_3  = [ 5.156589e+01 ; 4.748819e+01 ; 7.335708e+01 ];

%-- Image #4:
omc_4 = [ 2.161746e+00 ; 1.972948e+00 ; -3.543063e-01 ];
Tc_4  = [ -1.913724e+02 ; -1.562833e+02 ; 9.445758e+02 ];
omc_error_4 = [ 3.081989e-02 ; 4.249658e-02 ; 5.352027e-02 ];
Tc_error_4  = [ 4.308828e+01 ; 3.959175e+01 ; 6.257952e+01 ];

%-- Image #5:
omc_5 = [ 2.134510e+00 ; 1.983317e+00 ; -1.264163e-01 ];
Tc_5  = [ -1.218186e+02 ; -1.265512e+02 ; 8.903649e+02 ];
omc_error_5 = [ 3.453289e-02 ; 3.532985e-02 ; 6.087536e-02 ];
Tc_error_5  = [ 4.070917e+01 ; 3.696501e+01 ; 6.062081e+01 ];

%-- Image #6:
omc_6 = [ 2.148963e+00 ; 1.955850e+00 ; -1.645249e-01 ];
Tc_6  = [ -2.360234e+02 ; -1.180661e+02 ; 9.074831e+02 ];
omc_error_6 = [ 3.359727e-02 ; 3.966386e-02 ; 5.876836e-02 ];
Tc_error_6  = [ 4.162454e+01 ; 3.823584e+01 ; 6.161827e+01 ];

%-- Image #7:
omc_7 = [ 1.991700e+00 ; 1.912477e+00 ; -1.792443e-02 ];
Tc_7  = [ -4.174557e+02 ; -6.517764e+01 ; 9.931468e+02 ];
omc_error_7 = [ 3.160752e-02 ; 4.053061e-02 ; 7.467527e-02 ];
Tc_error_7  = [ 4.697959e+01 ; 4.357620e+01 ; 7.195591e+01 ];

%-- Image #8:
omc_8 = [ -2.248951e+00 ; -2.090292e+00 ; -1.360970e-01 ];
Tc_8  = [ -1.435643e+02 ; -1.571403e+02 ; 9.232001e+02 ];
omc_error_8 = [ 4.757058e-02 ; 4.396239e-02 ; 8.449218e-02 ];
Tc_error_8  = [ 4.236216e+01 ; 3.883136e+01 ; 6.246078e+01 ];

%-- Image #9:
omc_9 = [ 1.939299e+00 ; 1.845669e+00 ; -6.859359e-01 ];
Tc_9  = [ -1.448750e+02 ; -7.950822e+01 ; 1.062993e+03 ];
omc_error_9 = [ 2.701317e-02 ; 4.516135e-02 ; 4.882536e-02 ];
Tc_error_9  = [ 4.831199e+01 ; 4.439707e+01 ; 6.615254e+01 ];

%-- Image #10:
omc_10 = [ 1.780918e+00 ; 1.714409e+00 ; 2.375459e-01 ];
Tc_10  = [ -3.415619e+02 ; -5.244515e+01 ; 9.736363e+02 ];
omc_error_10 = [ 3.399516e-02 ; 3.067756e-02 ; 5.172981e-02 ];
Tc_error_10  = [ 4.585431e+01 ; 4.185003e+01 ; 7.004231e+01 ];

%-- Image #11:
omc_11 = [ 1.869086e+00 ; 1.727059e+00 ; 2.067654e-01 ];
Tc_11  = [ -3.602102e+02 ; -4.775543e+01 ; 9.724677e+02 ];
omc_error_11 = [ 3.367298e-02 ; 3.042712e-02 ; 5.464217e-02 ];
Tc_error_11  = [ 4.604285e+01 ; 4.195466e+01 ; 7.008993e+01 ];

%-- Image #12:
omc_12 = [ 2.022252e+00 ; 1.871137e+00 ; -9.201315e-02 ];
Tc_12  = [ -3.846913e+02 ; -5.198058e+01 ; 9.711640e+02 ];
omc_error_12 = [ 3.038856e-02 ; 3.891238e-02 ; 6.609904e-02 ];
Tc_error_12  = [ 4.538531e+01 ; 4.228635e+01 ; 6.861199e+01 ];

%-- Image #13:
omc_13 = [ 2.154649e+00 ; 1.933959e+00 ; -2.796908e-01 ];
Tc_13  = [ -1.330563e+02 ; -2.600483e+01 ; 9.335457e+02 ];
omc_error_13 = [ 3.641034e-02 ; 3.613419e-02 ; 6.182417e-02 ];
Tc_error_13  = [ 4.256247e+01 ; 3.896740e+01 ; 6.269563e+01 ];

%-- Image #14:
omc_14 = [ 2.152013e+00 ; 1.912469e+00 ; -3.497764e-01 ];
Tc_14  = [ -1.304729e+02 ; -4.259869e+01 ; 9.585934e+02 ];
omc_error_14 = [ 3.469802e-02 ; 3.754930e-02 ; 5.746240e-02 ];
Tc_error_14  = [ 4.361399e+01 ; 3.996710e+01 ; 6.330033e+01 ];

