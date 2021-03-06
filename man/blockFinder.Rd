\name{blockFinder}
\alias{blockFinder}
\title{
  Finds blocks of methylation differences for Illumina methylation arrays
}
\description{
  Finds blocks (large scale regions) of methylation differences for
  Illumina methylation arrays
}

\usage{
blockFinder(object, design, coef = 2, what = c("Beta", "M"),
                        cluster = NULL, cutoff = NULL,
                        pickCutoff = FALSE, pickCutoffQ = 0.99,
                        nullMethod = c("permutation","bootstrap"),
                        smooth = TRUE, smoothFunction = locfitByCluster,
                        B = ncol(permutations), permutations = NULL,
                        verbose = TRUE, bpSpan = 2.5*10^5,\dots)
}

\arguments{
  \item{object}{An object of class GenomicRatioSet.}
  \item{design}{Design matrix with rows representing samples and columns
    representing covariates. Regression is applied to each row of mat.}
  \item{coef}{An integer denoting the column of the design matrix
    containing the covariate of interest. The hunt for bumps will be
    only be done for the estimate of this coefficient.}
  \item{what}{Should blockfinding be performed on M-values or Beta
    values?}
  \item{cluster}{The clusters of locations that are to be analyzed
    together.  In the case of microarrays, the clusters are many times
    supplied by the manufacturer. If not available the function
    \code{\link{clusterMaker}} can be used to cluster nearby locations.}
 \item{cutoff}{A numeric value. Values of the estimate of the genomic
    profile above the cutoff or below the negative of the cutoff will be
    used as candidate regions.  It is possible to give two separate
    values (upper and lower bounds).  If one value is given, the lower
    bound is minus the value.}
  \item{pickCutoff}{Should a cutoff be picked automatically?}
  \item{pickCutoffQ}{The quantile used for picking the cutoff using the
    permutation distribution.}
  \item{nullMethod}{
    Method used to generate null candidate regions, must be one of \sQuote{bootstrap} or
    \sQuote{permutation} (defaults to \sQuote{permutation}). However, if covariates in addition to the 
    outcome of interest are included in the design matrix
    (ncol(design)>2), the \sQuote{permutation} approach is not
    recommended. See vignette and original paper for more information.}
  \item{smooth}{
    A logical value. If TRUE the estimated profile will be smoothed with the
    smoother defined by \code{smoothFunction}}
  \item{smoothFunction}{
    A function to be used for smoothing the estimate of the genomic
    profile. Two functions are provided by the package: \code{loessByCluster}
    and \code{runmedByCluster}.}
   \item{B}{An integer denoting the number of resamples to use when computing
   null distributions. This defaults to 0. If \code{permutations} is
  supplied that defines the number of permutations/bootstraps and \code{B} is
  ignored.}
\item{permutations}{ is a matrix with columns providing indexes to be used to
  scramble the data and create a null distribution. If this matrix is not supplied and \code{B}>0 then
  these indexes created using the function \code{sample}. }
  \item{verbose}{Should the function be verbose?}
  \item{bpSpan}{Smoothing span. Note that this defaults to a large value
  becuase we are searching for large scale changes.}
  \item{\dots}{further arguments sent to \code{bumphunterEngine}.}
}

\details{

The approximately 170,000 open sea probes on the 450k can be used to detect 
long-range changes in methylation status. These large scale changes that can range up
to several Mb have typically been identified only through whole-genome bisulfite 
sequencing. \code{blockFinder} groups the averaged methylation values in open-sea 
probe clusters (See \link{cpgCollapse}) into large regions in which the \link{bumphunter}
procedure is applied with a large (250KB+) smoothing window.

Note that estimating the precise boundaries of these blocks are constrained by the 
resolution of the array.
}

\value{
  FIXME
}

\seealso{
  \code{\link{cpgCollapse}}, and \code{\link{bumphunter}}
}

