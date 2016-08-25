## This script calculates the similarities between all
## histograms. Then, it compares the expected similarity to the actual
## similarity and uses this as a loss for a certain position. By
## iterating over all positions, it can assign a loss value to each
## position. Additionally, it provides an overall loss for an image
## (for a map).


compare.hists <- function(map.name,
                          base.name='/home/pold/Documents/map_evaluation',
                          N=1000,
                          write2csv=FALSE) {

    ## path of image patches
    p = sprintf('%s/%s', base.name, map.name);

    ## Path of x, y positions
    pos.name <- sprintf('%s/targets.csv', p);
    pos <- read.csv(pos.name)
    pos <- pos[, c("x", "y")]

    ## Iterate over images
    for (i in 0:(N-1)) {
        img.path <- sprintf('%s/img_%05d.png', p, i)
        print(img.path)
        I <- readPNG(img.path)
        means[i+1, ] <- colMeans(I, dims=2)
    }

    ## Write to file
    means <- data.frame(means)
    colnames(means) <- c("R", "G", "B")

    all.vals <- cbind(means, pos[1:N, ])

    # Save output in CSV file
    if (write2csv) {
        write.csv(all.vals, "data_stripes.csv", quote=FALSE, row.names=FALSE)
    }

    return(all.vals)

}
