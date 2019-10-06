
# Parameters.
filename_cell_signatures <- "D:\\USERYB\\Downloads\\test.csv"
filename_out <- "D:\\USERYB\\Downloads\\test_out.csv"
max_distance <- 2
max_marker_difference <- 1

# Data read in, and pre-processing.
cell_signatures <- read.csv(filename_cell_signatures, row.names=1, sep=";")

# Initial distance matrix.
if (ncol(cell_signatures) == 1) {
    write.csv(cell_signatures, file=filename_out)
    quit()
} else {
    distance_matrix <- abs(dist(t(cell_signatures)))
    signature_distances <- data.frame(t(combn(rownames(t(cell_signatures)),2)), as.numeric(distance_matrix))
    names(signature_distances) <- c("subset1", "subset2", "distance")
}

# Main loop, as long as there are similar pairs.
while (min(signature_distances$distance) < max_distance) {
    # Find minimum distance pair
    index <- which(signature_distances$distance == min(signature_distances$distance))
    name_1 <- toString(signature_distances[index[1], "subset1"]) # subset1 column
    name_2 <- toString(signature_distances[index[1], "subset2"]) # subset2
    subset_1 <- cell_signatures[,name_1]
    subset_2 <- cell_signatures[,name_2]

    # Check if any
    marker_difference = abs(subset_1 - subset_2)
    if (any(marker_difference < max_marker_difference)) {
        # Merge pair into one.
        new_cell_signature<- paste(name_1, name_2, sep="_")
        cell_signatures[[new_cell_signature]] <- rowMeans(cell_signatures[,c(name_1, name_2)])
        cell_signatures <- cell_signatures[,!(names(cell_signatures) %in% c(name_1, name_2))]
        cell_signatures <- as.data.frame(cell_signatures)
        # Make new distance matrix, if needed.
        if (ncol(cell_signatures) == 1) {
            write.csv(cell_signatures, file=filename_out)
            quit()
        } else {
            distance_matrix <- abs(dist(t(cell_signatures)))
            signature_distances <- data.frame(t(combn(rownames(t(cell_signatures)),2)), as.numeric(distance_matrix))
            names(signature_distances) <- c("subset1", "subset2", "distance")
        }
    } else {
        # Set distance to Inf when cannot merge.
        signature_distances[index,3] <- Inf # distance column
    }
}
write.csv(cell_signatures, file=filename_out)
quit()