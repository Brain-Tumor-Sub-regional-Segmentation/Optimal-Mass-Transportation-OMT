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
    %fid = fopen('outtttt.off', 'r');
    fid = fopen('flair2.off', 'r');
    % Read the header
    header = fscanf(fid, '%s', 1);
    if ~strcmp(header, 'OFF')
        error('Invalid .off file format.');
    end
    
    % Read the number of vertices, faces, and edges
    numVertices = fscanf(fid, '%d', 1);
    numFaces = fscanf(fid, '%d', 1);
    numEdges = fscanf(fid, '%d', 1);
    
    % Read the vertex coordinates
    vertices = fscanf(fid, '%f', [3, numVertices])';
    
    % Read the face indices for triangles
    faces = fscanf(fid, '%*d %d %d %d', [3, numFaces])';
    
    % Close the file
    fclose(fid);

    % Save data to a MAT-file
    save('outBrain.mat', 'vertices', 'faces');
%load('outBrain.mat')
addpath('mfile')
v=double(vertices);
f=double(faces);
disp(class(v));
disp(class(f));
f=f+1;
plot_mesh(v,f); view([-130 0])

map = spherical_conformal_map(v,f);

plot_mesh(map,f); 

% evaluate the angle distortion
angle_distortion(v,f,map);

%% Example 2: Chinese lion
load('lion.mat')
% plot_mesh(v,f);
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(v,f,mean_curv);

map = spherical_conformal_map(v,f);

% plot_mesh(map,f); view([-70 0])
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(map,f,mean_curv); view([-70 0])

% evaluate the angle distortion
angle_distortion(v,f,map);

%% Example 3: Brain
load('brain.mat')
% plot_mesh(v,f); view([90 0])
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(v,f,mean_curv); view([90 0]); 

map = spherical_conformal_map(v,f);

% plot_mesh(map,f); view([-30 0]);
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(map,f,mean_curv); view([-30 0]);

% evaluate the angle distortion
angle_distortion(v,f,map);
