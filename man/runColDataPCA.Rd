% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runColDataPCA.R
\name{runColDataPCA}
\alias{runColDataPCA}
\title{Perform PCA on column metadata}
\usage{
runColDataPCA(x, ncomponents = 2, scale_features = TRUE,
  selected_variables = NULL, detect_outliers = FALSE,
  BSPARAM = ExactParam(), BPPARAM = SerialParam(),
  name = "PCA_coldata")
}
\arguments{
\item{x}{A \linkS4class{SingleCellExperiment} object.}

\item{ncomponents}{Numeric scalar indicating the number of principal components to obtain.
This will override any \code{ntop} argument if specified.}

\item{scale_features}{Logical scalar, should the expression values be standardised so that each feature has unit variance?
This will also remove features with standard deviations below 1e-8.}

\item{selected_variables}{List of strings or a character vector indicating which variables in \code{colData(x)} to use.
If a list, each entry can take the form described in \code{?"\link{scater-vis-var}"}.}

\item{detect_outliers}{Logical indicating whether outliers should be detected based on PCA coordinates.}

\item{BSPARAM}{A \linkS4class{BiocSingularParam} object specifying which algorithm should be used to perform the PCA.}

\item{BPPARAM}{A \linkS4class{BiocParallelParam} object specifying whether the PCA should be parallelized.}

\item{name}{String specifying the name to be used to store the result in the \code{reducedDims} of the output.}
}
\value{
A SingleCellExperiment object containing the first \code{ncomponent} principal coordinates for each cell.
By default, these are stored in the \code{"PCA_coldata"} entry of the \code{reducedDims} slot.
The proportion of variance explained by each PC is stored as a numeric vector in the \code{"percentVar"} attribute.

If \code{detect_outliers=TRUE}, the output \code{colData} will also contain a logical \code{outlier} field.
This specifies the cells that correspond to the identified outliers.
}
\description{
Perform a principal components analysis (PCA) on cells, 
based on the column metadata in a SingleCellExperiment object.
}
\details{
This function performs PCA on column-level metadata instead of the gene expression matrix. 
The \code{selected_variables} defaults to a vector containing:
\itemize{
\item \code{"pct_counts_top_100_features"}
\item \code{"total_features_by_counts"}
\item \code{"pct_counts_feature_control"}
\item \code{"total_features_feature_control"}
\item \code{"log10_total_counts_endogenous"}
\item \code{"log10_total_counts_feature_control"}
}

The default variables are useful for identifying outliers cells based on QC metrics when \code{detect_outliers=TRUE}.
This uses an \dQuote{outlyingness} measure computed by \code{adjOutlyingness} in the \pkg{robustbase} package.
Outliers are defined those cells with outlyingness values more than 5 MADs above the median, using \code{\link{isOutlier}}.
}
\examples{
## Set up an example SingleCellExperiment
data("sc_example_counts")
data("sc_example_cell_info")
example_sce <- SingleCellExperiment(
    assays = list(counts = sc_example_counts),
    colData = sc_example_cell_info
)
example_sce <- normalize(example_sce)

example_sce <- calculateQCMetrics(example_sce,
    feature_controls=list(Spike=1:10))
example_sce <- runColDataPCA(example_sce)
reducedDimNames(example_sce)
head(reducedDim(example_sce))

}
\seealso{
\code{\link[scater]{runPCA}}, for the corresponding method operating on expression data.
}
\author{
Aaron Lun, based on code by Davis McCarthy
}
