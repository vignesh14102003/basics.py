cam_img = imread('cameraman.tif'); 

cam_resized = imresize(cam_img, [128, 128]);

img = uint8(32 * ones (1024,1024));

img(257:768, 257:768) = 64;

img(385:640, 385:640) = 128;

img(449:576, 449:576) = cam_resized;

figure; 

imshow(img);

% Vignesh Ramkumar - ImProc Lab Session 1
% Course: EURECOM ImProc (Fall 2026)
%% Section II.B: Mosaic

peppers = imread('peppers.png');
[r, c, ~] = size(peppers);

top_left = peppers;

top_right = zeros(r, c, 3, 'like', peppers);
top_right(:,:,3) = flipud(peppers(:,:,3));

bottom_left = zeros(r, c, 3, 'like', peppers);
bottom_left(:,:,1) = fliplr(peppers(:,:,1));

bottom_right = zeros(r, c, 3, 'like', peppers);
bottom_right(:,:,2) = fliplr(flipud(peppers(:,:,2)));

mosaic = [top_left, top_right; bottom_left, bottom_right];

figure;
imshow(mosaic);
title('Mosaic with color channels');

% --- Comment on the steps followed ---
% 1. Isolated single RGB channels into 3D zero matrices to retain true color visualization.
% 2. Applied flipud for vertical flipping, fliplr for horizontal flipping, and combined both for the green channel.
% 3. Concatenated the 4 sub-images into a 2x2 grid using matrix concatenation [top; bottom].



%% Section II.C: 3D Image
% Step 1: Read the original 'peppers.png' image
peppers = imread('peppers.png');

% Step 2: Resize the image to half its size
peppers_half = imresize(peppers, 0.5);

% Step 3: Compute its gray level (grayscale conversion)
peppers_gray = rgb2gray(peppers_half);

% Step 4: Display the image as a 3D surface
figure;
s = surf(double(peppers_gray));

% Step 5: Remove mesh lines for seamless visualization
set(s, 'LineStyle', 'none');

% Step 6: Set colormap to 256 grayscale levels
colormap(gray(256));
colorbar; % Adds intensity scale bar

% Add axis labels and title
title('3D Surface Representation of Peppers');
xlabel('X (Columns)');
ylabel('Y (Rows)');
zlabel('Luminance (Pixel Value)');

% Optional: Set initial 3D viewing angle
view(3); 


% --- Comment on the steps followed ---
% 1. imresize(peppers, 0.5) reduces image resolution to half, speeding up 3D surface rendering.
% 2. rgb2gray() converts RGB color channels into a single luminance channel with pixel values from 0 to 255.
% 3. surf(double(peppers_gray)) assigns pixel intensity values to the Z-axis (height), causing brighter regions to appear higher.
% 4. set(s, 'LineStyle', 'none') strips the black wireframe lines from the surface patches so the image renders smoothly.
% 5. colormap(gray(256)) applies a 256-level grayscale palette so the surface matches original gray shading when viewed from directly above (view(2)).

%% Section II.D: Bitplane Slicing
% Step 1: Read the cameraman image (ensure cameraman.png is downloaded from Moodle)
cam = imread('cameraman.tif');

% Step 2: Create a single figure window for all 8 bitplanes
figure;

% Step 3: Loop through all 8 bit positions (1 = LSB, 8 = MSB)
for k = 1:8
    % Extract the k-th bit using bitget (or using: mod(floor(double(cam) / 2^(k-1)), 2))
    bit_plane = bitget(cam, k);

    % Display in a 2x4 grid layout
    subplot(2, 4, k);
    imshow(logical(bit_plane));
    title(['Bit plane for bit #' num2str(k)]);
end


% =========================================================================
% ANSWERS TO REQUIRED QUESTIONS (Include as comments in your .m file)
% =========================================================================

% --- Comment on the steps followed ---
% 1. Read 'cameraman.png' using imread().
% 2. Used a loop from k = 1 to 8 to extract each bit plane using bitget(cam, k).
% 3. Converted the extracted bit arrays to logical matrices and plotted each in a 2x4 subplot layout using subplot(2, 4, k) and imshow().

% --- Answer & Justification for Most / Least Significant Bit Planes ---
% Most Significant Bit Plane: Bit #8 (MSB)
% Justification: Bit #8 holds the highest binary weight (2^7 = 128). It contains the vast majority of the visual luminance information, structural contours, and main shapes (cameraman silhouette, sky, and ground).
%
% Least Significant Bit Plane: Bit #1 (LSB)
% Justification: Bit #1 holds the lowest binary weight (2^0 = 1). It contains mostly imperceptible high-frequency random noise and fine details, offering no recognizable structural content of the scene.
