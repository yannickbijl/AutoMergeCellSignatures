# AutoMergeCellSignatures
## Introduction
Cell signatures are commonly used for identifying groups of cells in a heterogenous dataset. A cell signature describes with a given set of markers the characterization of a single specific homogeneous set of cells. Thus association between measured samples and gene signatures can identify the cell types in a sample.

These cell signatures can be characterized in several ways. Methods based on flow- and mass-cytometry most often use surface proteins as markers. Microarray and RNA-Seq data mostly use gene-probes as markers. Despite the difference in method, cell signatures suffer in both cases from the same problem.

A cell signature should be unique for a single cell type. This is often done using a large set of markers. When using the cell signatures in a later stage, these markers are subsetted to match the markers of the sample. At this point, cell signatures are not guaranteed to be unique anymore, thus losing its capacity to identify single cell types.

Most methods for downstream analysis would benefit from an additional step that ensures that all cell signatures are unique. To this end I developed AutoMergeCellSignatures. An R script that merges cell signatures based on their similarity.

## Method

## Results
Text

## Discussion
Text
