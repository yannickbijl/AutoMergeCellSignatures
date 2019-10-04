
# Parameters.
filename_cell_signatures <- "D:\\USERYB\\Downloads\\test.csv"
max_distance <- 2
max_marker_difference <- 1

# Data read in, and pre-processing.
cell_signatures <- read.csv(filename_cell_signatures, row.names=1, sep=";")

# Initial distance matrix.
distance_matrix <- abs(dist(t(cell_signatures)))
cell_signature_distances <- data.frame(t(combn(rownames(t(cell_signatures)),2)), as.numeric(distance_matrix))
names(cell_subset_distances) <- c("subset1", "subset2", "distance")