filename_cell_signatures <- "D:\\USERYB\\Downloads\\test.csv"

cell_signatures <- read.csv(filename_cell_signatures, row.names=1, sep=";")

distance_matrix <- abs(dist(t(cell_signatures)))
cell_signature_distances <- data.frame(t(combn(rownames(t(cell_signatures)),2)), as.numeric(distance_matrix))