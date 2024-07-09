# Brain-Tumor-Segmentation
- We follow the implementation of this paper https://www.nature.com/articles/s41598-022-10285-x and this one https://www.nature.com/articles/s41598-021-94071-1


# Issues we found with Omt 
- Despite closely following the pseudocode provided in the reference paper, we encountered several critical issues in the implementation of the Optimal Mass Transportation (OMT) algorithm that prevent us from continuing with its deployment. The specific challenges are detailed below:

 **1. ASEM Algorithm and Laplacian Matrix:**
 - The generated Laplacian matrix (L) is not a semi-positive definite matrix as required. During our
 implementation, we observed that some off-diagonal entries of the matrix
 had positive weights, which we set to zero. However, this adjustment
 did not resolve the issue, and the matrix (L) remained non-semi-positive
 definite.

 **2. Oscillation and Convergence of Energy and Cost Functions:**
 - We observed significant oscillations in some energy and cost functions,and in certain instances, these functions took an excessively long timeto converge. This behavior indicates instability and inefficiency in the
 algorithm’s performance, further complicating its practical application.

->  We attempted to resolve these issues by contacting the authors of the referenced paper for guidance, but we have not received a response. Consequently, we have decided to shift our focus towards enhancing and evaluating
 alternative models for 3D brain tumor segmentation.
