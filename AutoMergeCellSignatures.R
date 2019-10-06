
# Parameters.
filename_cell_signatures <- "D:\\USERYB\\Downloads\\test.csv"
max_distance <- 2
max_marker_difference <- 1

# Data read in, and pre-processing.
cell_signatures <- read.csv(filename_cell_signatures, row.names=1, sep=";")

# Initial distance matrix.
distance_matrix <- abs(dist(t(cell_signatures)))
cell_signature_distances <- data.frame(t(combn(rownames(t(cell_signatures)),2)), as.numeric(distance_matrix))
names(cell_signature_distances) <- c("subset1", "subset2", "distance")

while (min(cell_signature_distances$distance) < max_distance) {
    index <- which(cell_signature_distances$distance == min(cell_signature_distances$distance))

    name_1 <- toString(cell_signature_distances[index[1], "subset1"]) # subset1 column
    name_2 <- toString(cell_signature_distances[index[1], "subset2"]) # subset2

    subset_1 <- cell_signatures[,name_1]
    subset_2 <- cell_signatures[,name_2]
    marker_difference = abs(subset_1 - subset_2)

    if (any(marker_difference < max_marker_difference)) {
        new_cell_signature<- paste(name_1, name_2, sep="_")
        cell_signatures[[new_cell_signature]] <- rowMeans(cell_signatures[,c(name_1, name_2)])
        cell_signatures <- cell_signatures[,!(names(cell_signatures) %in% c(name_1, name_2))]
    }
    cell_signature_distances[index,3] <- Inf # distance column
}
print(cell_signatures)
