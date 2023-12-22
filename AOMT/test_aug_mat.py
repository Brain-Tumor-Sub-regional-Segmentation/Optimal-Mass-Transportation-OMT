import numpy as np


def test_edge_aug_matrix_1(build_adj_mat_fn, build_edge_aug_mat_f4_fn):
  v = np.zeros((7, 3))
  
  f = []
  f.append([0, 1, 6])
  f.append([1, 2, 6])
  f.append([3, 2, 6])
  f.append([3, 4, 6])
  f.append([4, 5, 6])
  f.append([0, 5, 6])
  f.append([5, 3, 4])
  f = np.sort(np.array(f), axis=1)

  adj_matrix = build_adj_mat_fn(f, v.shape[0])
  print(adj_matrix)
  adj_matrix_right = np.array([
    [0, 1, 0, 0, 0, 1, 1],
    [1, 0, 1, 0, 0, 0, 1],
    [0, 1, 0, 1, 0, 0, 1],
    [0, 0, 1, 0, 1, 1, 1],
    [0, 0, 0, 1, 0, 1, 1],
    [1, 0, 0, 1, 1, 0, 1],
    [1, 1, 1, 1, 1, 1, 0]], dtype=bool)
  assert np.array_equal(adj_matrix, adj_matrix_right), "Matrices are not equal"
  print("\033[92mAdjacency Matrix is correct\033[0m") 
  aug_matrix = build_edge_aug_mat_f4_fn(adj_matrix, f)
  aug_matrix_right = np.array([
    [0, 6, 1, 5],
    [1, 6, 0, 2],
    [2, 6, 1, 3],
    [3, 4, 5, 6],
    [3, 6, 2, 4],
    [4, 5, 3, 6],
    [4, 6, 3, 5],
    [5, 6, 0, 4]])
  print(aug_matrix)
  assert np.array_equal(aug_matrix, aug_matrix_right)
  print("\033[92mFirst 4 Columns of Edge Augmented Matrix are correct\033[0m")
  print("\033[92m Success!\033[0m") 

compute_face_area = lambda v1, v2, v3: 0.5 * np.linalg.norm(np.cross(v2 - v1, v3 - v1))

def test_edge_aug_matrix_2(row, vertices, v_densities):
  a1 = compute_face_area(vertices[int(row[0])], vertices[int(row[1])], vertices[int(row[2])])
  a2 = compute_face_area(vertices[int(row[0])], vertices[int(row[1])], vertices[int(row[3])])
  d1 = (v_densities[int(row[0])] + v_densities[int(row[1])] + v_densities[int(row[2])]) / 3
  d2 = (v_densities[int(row[0])] + v_densities[int(row[1])] + v_densities[int(row[3])]) / 3
  assert a1 == row[4] and a2 == row[5] and d1 == row[6] and d2 == row[7] 
  print("\033[92mAreas and Densities are Correct\033[0m")
  print("\033[92m Success!\033[0m") 
