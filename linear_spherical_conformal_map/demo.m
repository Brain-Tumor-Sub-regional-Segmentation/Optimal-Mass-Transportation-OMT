% A linear method for computing spherical conformal map of genus-0 closed triangle meshes
%
% Main program:
% map = spherical_conformal_map(v,f)
% 
% Input:
% v: nv x 3 vertex coordinates of a genus-0 closed triangle mesh
% f: nf x 3 triangulations of a genus-0 closed triangle mesh
%
% Output:
% map: nv x 3 vertex coordinates of the spherical conformal map
% 
% Remark:
% See demo_extension.m to understand how the method can be extended for
% further reducing the area distortion
% 
% If you use this code in your own work, please cite the following paper:
% [1] P. T. Choi, K. C. Lam, and L. M. Lui, 
%     "FLASH: Fast Landmark Aligned Spherical Harmonic Parameterization for Genus-0 Closed Brain Surfaces."
%     SIAM Journal on Imaging Sciences, vol. 8, no. 1, pp. 67-94, 2015.
%
% Copyright (c) 2013-2018, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi
%% Example 1: David

% Read the .off file
    % Check the number of input arguments
    printf('Num of args %d\n', nargin)
    if nargin != 1
      error("Usage: demo.m input_file_path");
    endif
    
    % Get the input mesh file name from command-line arguments
    input_file_path = argv(){1};
    
    printf('%s\n', input_file_path)
    fid = fopen(input_file_path, 'r');
    % Read the header
    header = fscanf(fid, '%s', 1);
    if ~strcmp(header, 'OFF')
        error('Invalid .off file format.');
    end
    
    % Read the number of vertices, faces, and edges
    num_vertices = fscanf(fid, '%d', 1);
    num_faces = fscanf(fid, '%d', 1);
    num_edges = fscanf(fid, '%d', 1);
    
    % Read the vertex coordinates
    vertices = fscanf(fid, '%f', [3, num_vertices])';
    
    % Read the face indices for triangles
    faces = fscanf(fid, '%*d %d %d %d', [3, num_faces])';
    
    % Close the file
    fclose(fid);

    % Save data to a MAT-file
    save('linear_spherical_conformal_map/outBrain.mat', 'vertices', 'faces');
%load('linear_spherical_conformal_map/outBrain.mat')
addpath('linear_spherical_conformal_map/mfile')
v=double(vertices);
f=double(faces);
disp(class(v));
disp(class(f));
f=f+1;
% plot_mesh(v,f); view([-130 0])

map = spherical_conformal_map(v,f);

% Specify the output file name
output_file_name = 'linear_spherical_conformal_map/spherical_conformal_map_output.txt';

% Open the output file for writing
fid = fopen(output_file_name, 'w');

% Check if the file is opened successfully
if fid == -1
    error('Error opening the output file.');
end

fprintf(fid, '%d\n', size(map, 1));

% Write each vertex coordinate to the file
for i = 1:size(map, 1)
    fprintf(fid, '%f %f %f\n', map(i, 1), map(i, 2), map(i, 3));
end

% Close the output file
fclose(fid);

disp(['Spherical conformal map written to ' output_file_name]);