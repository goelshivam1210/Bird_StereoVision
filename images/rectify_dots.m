% rectify_stereo_pair.m
%
% Script file that rectifies a set of stereo images after stereo calibration
% This script loads the stereo calibration file Calib_Results_stereo generated by calib_stereo.m
% Therefore, type help calib_stereo for more information.


if ~exist('fc_right')|~exist('cc_right')|~exist('kc_right')|~exist('alpha_c_right')|~exist('fc_left')|~exist('cc_left')|~exist('kc_left')|~exist('alpha_c_left')|~exist('om')|~exist('T')
    
    if exist('Calib_Results_stereo.mat')~=2,
        fprintf(1,'No stereo calibration data.\n');
        return;
    else
        fprintf(1,'\nLoading the stereo calibration file Calib_Results_stereo.mat.\n');
        load Calib_Results_stereo; % Load the stereo calibration result
    end;
    
end;



fprintf(1,'\nCalculating the rotation to be applied to the right and left images in order to bring the epipolar lines aligned with the horizontal scan lines, and in correspondence...\n\n');

R = rodrigues(om);

% Bring the 2 cameras in the same orientation by rotating them "minimally": 
r_r = rodrigues(-om/2);
r_l = r_r';
t = r_r * T;

% Rotate both cameras so as to bring the translation vector in alignment with the (1;0;0) axis:
if abs(t(1)) > abs(t(2)),
    type_stereo = 0;
    uu = [1;0;0]; % Horizontal epipolar lines
else
    type_stereo = 1;
    uu = [0;1;0]; % Vertical epipolar lines
end;
if dot(uu,t)<0,
    uu = -uu; % Swtich side of the vector 
end;
ww = cross(t,uu);
ww = ww/norm(ww);
ww = acos(abs(dot(t,uu))/(norm(t)*norm(uu)))*ww;
R2 = rodrigues(ww);


% Global rotations to be applied to both views:
R_R = R2 * r_r;
R_L = R2 * r_l;


% The resulting rigid motion between the two cameras after image rotations (substitutes of om, R and T):
R_new = eye(3);
om_new = zeros(3,1);
T_new = R_R*T;




% Computation of the *new* intrinsic parameters for both left and right cameras:

% Vertical focal length *MUST* be the same for both images (here, we are trying to find a focal length that retains as much information contained in the original distorted images):
if kc_left(1) < 0,
    fc_y_left_new = fc_left(2) * (1 + kc_left(1)*(nx^2 + ny^2)/(4*fc_left(2)^2));
else
    fc_y_left_new = fc_left(2);
end;
if kc_right(1) < 0,
    fc_y_right_new = fc_right(2) * (1 + kc_right(1)*(nx^2 + ny^2)/(4*fc_right(2)^2));
else
    fc_y_right_new = fc_right(2);
end;
fc_y_new = min(fc_y_left_new,fc_y_right_new);


% For simplicity, let's pick the same value for the horizontal focal length as the vertical focal length (resulting into square pixels):
fc_left_new = round([fc_y_new;fc_y_new]);
fc_right_new = round([fc_y_new;fc_y_new]);

% Select the new principal points to maximize the visible area in the rectified images

cc_left_new = [(nx-1)/2;(ny-1)/2] - mean(project_points2([normalize_pixel([0  nx-1 nx-1 0; 0 0 ny-1 ny-1],fc_left,cc_left,kc_left,alpha_c_left);[1 1 1 1]],rodrigues(R_L),zeros(3,1),fc_left_new,[0;0],zeros(5,1),0),2);
cc_right_new = [(nx-1)/2;(ny-1)/2] - mean(project_points2([normalize_pixel([0  nx-1 nx-1 0; 0 0 ny-1 ny-1],fc_right,cc_right,kc_right,alpha_c_right);[1 1 1 1]],rodrigues(R_R),zeros(3,1),fc_right_new,[0;0],zeros(5,1),0),2);


% For simplivity, set the principal points for both cameras to be the average of the two principal points.
if ~type_stereo,
    %-- Horizontal stereo
    cc_y_new = (cc_left_new(2) + cc_right_new(2))/2;
    cc_left_new = [cc_left_new(1);cc_y_new];
    cc_right_new = [cc_right_new(1);cc_y_new];
else
    %-- Vertical stereo
    cc_x_new = (cc_left_new(1) + cc_right_new(1))/2;
    cc_left_new = [cc_x_new;cc_left_new(2)];
    cc_right_new = [cc_x_new;cc_right_new(2)];
end;


% Of course, we do not want any skew or distortion after rectification:
alpha_c_left_new = 0;
alpha_c_right_new = 0;
kc_left_new = zeros(5,1);
kc_right_new = zeros(5,1);


% The resulting left and right camera matrices:
KK_left_new = [fc_left_new(1) fc_left_new(1)*alpha_c_left_new cc_left_new(1);0 fc_left_new(2) cc_left_new(2); 0 0 1];
KK_right_new = [fc_right_new(1) fc_right_new(1)*alpha_c_right cc_right_new(1);0 fc_right_new(2) cc_right_new(2); 0 0 1];

% The sizes of the images are the same:
nx_right_new = nx;
ny_right_new = ny;
nx_left_new = nx;
ny_left_new = ny;

% Save the resulting extrinsic and intrinsic paramters into a file:
fprintf(1,'Saving the *NEW* set of intrinsic and extrinsic parameters corresponding to the images *AFTER* rectification under Calib_Results_stereo_rectified.mat...\n\n');
save Calib_Results_stereo_rectified om_new R_new T_new  fc_left_new cc_left_new kc_left_new alpha_c_left_new KK_left_new fc_right_new cc_right_new kc_right_new alpha_c_right_new KK_right_new nx_right_new ny_right_new nx_left_new ny_left_new



% Let's rectify the entire set of calibration images:

fprintf(1,'Pre-computing the necessary data to quickly rectify the images (may take a while depending on the image resolution, but needs to be done only once - even for color images)...\n\n');

% Pre-compute the necessary indices and blending coefficients to enable quick rectification: 
[Irec_junk_left,ind_new_left,ind_1_left,ind_2_left,ind_3_left,ind_4_left,a1_left,a2_left,a3_left,a4_left] = rect_index(zeros(ny,nx),R_L,fc_left,cc_left,kc_left,alpha_c_left,KK_left_new);
[Irec_junk_left,ind_new_right,ind_1_right,ind_2_right,ind_3_right,ind_4_right,a1_right,a2_right,a3_right,a4_right] = rect_index(zeros(ny,nx),R_R,fc_right,cc_right,kc_right,alpha_c_right,KK_right_new);

clear Irec_junk_left

    %% Test of rectification for 2 images:
    
    % left image:
    I = double(rgb2gray(imread('dotleft6.jpg')));
    I2 = 255*ones(ny,nx);
    I2(ind_new_left) = uint8(a1_left .* I(ind_1_left) + a2_left .* I(ind_2_left) + a3_left .* I(ind_3_left) + a4_left .* I(ind_4_left));
    imwrite(uint8(I2),gray(256),'dotleft6_rect.jpg','jpg');
    imgl = uint8(I2);
    
    % right image:
    I = double(rgb2gray(imread('dotright6.jpg')));
    I2 = 255*ones(ny,nx);
    I2(ind_new_right) = uint8(a1_right .* I(ind_1_right) + a2_right .* I(ind_2_right) + a3_right .* I(ind_3_right) + a4_right .* I(ind_4_right));
    imwrite(uint8(I2),gray(256),'dotright6_rect.jpg','jpg');
    img_r = uint8(I2);
    
    

    


