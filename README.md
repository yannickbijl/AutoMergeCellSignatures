# AutoMergeCellSignatures
## Introduction
Cell signatures are commonly used for identifying groups of cells in a heterogenous dataset. A cell signature describes with a given set of markers the characterization of a single specific homogeneous set of cells. Thus association between measured samples and gene signatures can identify the cell types in a sample.

These cell signatures can be characterized in several ways. Methods based on flow- and mass-cytometry most often use surface proteins as markers. Microarray and RNA-Seq data mostly use gene-probes as markers. Despite the difference in method, cell signatures suffer in both cases from the same problem.

A cell signature should be unique for a single cell type. This is often done using a large set of markers. When using the cell signatures in a later stage, these markers are subsetted to match the markers of the sample. At this point, cell signatures are not guaranteed to be unique anymore, thus losing its capacity to identify single cell types.

Most methods for downstream analysis would benefit from an additional step that ensures that all cell signatures are unique. To this end I developed AutoMergeCellSignatures. A R script that merges cell signatures based on their similarity.

## Method
The script has four parameters. Two are the in- and output files. The other two are for the acceptable measure of dissimilarity, defining how unique a cell signature should be.

The `min_distance` parameter is the minimal distance between cell types to be considered unique. All cell types that are far enough to all other cell types are considered to be having unique cell signatures. Every pair of cell types with a lower distance is considered to be highly similar. However, this does not indicate that the cell signatures are not unique. An additional test is needed for determining the uniqueness in those cases.

This is where the other parameter `max_marker_difference` comes into. This paramter is the minimal amount of difference a single marker in the cell signature must have to be considered unique.

## Results
Text

## Discussion
Text
