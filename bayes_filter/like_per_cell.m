function [ p ] = like_per_cell(expected, actual, cov_hists )

    p = mvnpdf(actual, expected, cov_hists);

end