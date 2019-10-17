library("argparse")

read_cell_signatures <- function(filename, separator=",") {
    cell_signatures <- read.csv(filename, row.names=1, sep=separator)
    return(cell_signatures)
}

save_cell_signatures <- function(filename, signatures, separator=",") {
    write.table(signatures, file=filename, sep=separator)
    quit()
}

make_distance_matrix <- function(signatures, filename) {
    if (ncol(signatures) == 1) {
        save_cell_signatures(filename, signatures)
    } else {
        # Make distance matrix and turn into easy readable and parsable format.
        distance_matrix <- abs(dist(t(signatures)))
        signature_distances <- data.frame(t(combn(rownames(t(signatures)),2)), as.numeric(distance_matrix))
        names(signature_distances) <- c("subset1", "subset2", "distance")
    }
    return(signature_distances)
}

merge_cell_signatures <- function(cell_signatures, min_d, max_md, file_out) {
    signature_distances <- make_distance_matrix(cell_signatures, file_out)
    # Main loop, as long as there are similar pairs.
    while (min(signature_distances$distance) < min_d) {
        # Find minimum distance pair
        index <- which(signature_distances$distance == min(signature_distances$distance))
        name_1 <- toString(signature_distances[index[1], "subset1"]) # subset1 column
        name_2 <- toString(signature_distances[index[1], "subset2"]) # subset2
        subset_1 <- cell_signatures[,name_1]
        subset_2 <- cell_signatures[,name_2]

        # Check if all markers are "identical"
        marker_difference = abs(subset_1 - subset_2)
        if (all(marker_difference < max_md)) {
            # Merge pair into one, add to the cell signatures, and remove original pair.
            new_cell_signature<- paste(name_1, name_2, sep="_")
            cell_signatures[[new_cell_signature]] <- rowMeans(cell_signatures[,c(name_1, name_2)])
            cell_signatures <- cell_signatures[,!(names(cell_signatures) %in% c(name_1, name_2))]
            cell_signatures <- as.data.frame(cell_signatures)
            # Make new distance matrix, if needed.
            signature_distances <- make_distance_matrix(cell_signatures, file_out)
        } else {
            # Set distance to Inf when cannot merge.
            signature_distances[index,3] <- Inf # distance column
        }
    }
    save_cell_signatures(file_out, cell_signatures)
}

main <- function(args) {
    cell_signatures <- read_cell_signatures(args$signatures)
    merge_cell_signatures(cell_signatures, args$min_d, args$max_md, args$output)
}

# Arguments
parser <- ArgumentParser()
parser$add_argument("signatures", type="character", help="file with the gene signatures")
parser$add_argument("output", type="character", help="file to which merged signatures will be written to")
parser$add_argument("-min", "--min_distance", type="integer", default=2, help="minimum distance between signatures to be considered unique", metavar="min_d")
parser$add_argument("-max", "--max_marker_difference", type="integer", default=1, help="maximum difference between markers to be considered identical, if all markers are identical the signatures will be merged", metavar="max_md")

args <- parser$parse_args()

main(args)