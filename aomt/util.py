"""Importing Necessary Libraries, Packages and Functions"""
import open3d as o3d
import numpy as np
import nibabel as nib
from scipy.interpolate import RegularGridInterpolator
from scipy.ndimage import map_coordinates
from cehe.cehe_algorithm import get_density_map, cehe, inverted_average_fn

"""Some Utility Functions:"""

"""A Function that compute density of voxels after contrast enhancement"""
def build_density_map(file_path):
  img = nib.load(file_path)
  img_arr = img.get_fdata()
  normalized_img_arr = (img_arr - np.mean(img_arr)) / np.std(img_arr)
  enhanced_img_arr = cehe(normalized_img_arr, inverted_average_fn, 3, 65536)
  enhanced_image = nib.Nifti1Image(enhanced_img_arr, affine=np.eye(4))
  return get_density_map(enhanced_image, 1)

"""A Function to read .off file format and extract vertices and faces"""
def read_off_file(file_path):
  mesh = o3d.io.read_triangle_mesh(file_path)
  vertices = np.asarray(mesh.vertices)
  faces = np.asarray(mesh.triangles)
  return vertices, np.sort(faces, axis=1)


"""A Function to compute vertices density"""
"""It performs Trilinear Interpolation on each vertex coordinate to get its density from the image density map."""

get_vertices_density = lambda d_map, vertices: map_coordinates(d_map, vertices.T, order=1, mode='nearest')

""""A Function to save vertices and faces in .off file format"""
def save_mesh(vertices, faces, file_name):
  mesh = o3d.geometry.TriangleMesh()
  mesh.vertices = o3d.utility.Vector3dVector(vertices)
  mesh.triangles = o3d.utility.Vector3iVector(faces)
  o3d.io.write_triangle_mesh(file_name, mesh)