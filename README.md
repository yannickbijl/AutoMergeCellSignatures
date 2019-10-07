# AutoMergeCellSignatures
## Introduction
Cell signatures are commonly used for identifying groups of cells in a heterogenous dataset. A cell signature describes with a given set of markers the characterization of a single specific homogeneous set of cells. Thus association between measured samples and gene signatures can identify the cell types in a sample.

These cell signatures can be characterized in several ways. Methods based on flow- and mass-cytometry most often use surface proteins as markers. Microarray and RNA-Seq data mostly use gene-probes as markers. Despite the difference in method, cell signatures suffer in both cases from the same problem.

A cell signature should be unique for a single cell type. This is often done using a large set of markers. When using the cell signatures in a later stage, these markers are subsetted to match the markers of the sample. At this point, cell signatures are not guaranteed to be unique anymore, thus losing its capacity to identify single cell types.

Most methods for downstream analysis would benefit from an additional step that ensures that all cell signatures are unique. To this end I developed AutoMergeCellSignatures. A R script that merges cell signatures based on their similarity.

## Method
The script has four parameters. Two are the in- and output files. The other two are for the acceptable measure of dissimilarity, defining how unique a cell signature should be.

The `min_distance` parameter is the minimal distance between cell types to be considered unique. All cell types that are far enough to all other cell types are considered to be having unique cell signatures. Every pair of cell types with a lower distance is considered to be highly similar. However, this does not indicate that the cell signatures are not unique. An additional test is needed for determining the uniqueness in those cases.

This is where the other parameter `max_marker_difference` comes into. This parameter is the minimal amount of difference a single marker in the cell signature must have to be considered unique. Thus a cell signatures can be considered unique when it has a minimum distance to all other cell signatures or at least a single marker is differential enough.

The script uses an iterative design similar to hierarchical clustering. The workflow can be seen below. The input being a set of signatures, a distance matrix is calculated using Euclidean distance. The pair of signatures with the lowest distance is taken and further inspected. The inspection ensures that none of the markers are too different, ensuring true similarity between the cell signatures.

When cell signatures are similar, they are combined into a single cell signature. In the case that cell signatures are merged, a new distance matrix will be calculated. When cell signatures cannot be merged, the next pair is inspected. This continues till all cell signatures are deemed unique or are merged into a single cell signature. The output being the merged cell signatures.

## Discussion
Text
