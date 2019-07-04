#' Obtain the Grun HSC data
#'
#' Download and cache the Grun HSC single-cell RNA-seq (scRNA-seq) dataset from ExperimentHub,
#' returning a \linkS4class{SingleCellExperiment} object for further use.
#'
#' @details
#' This function provides the haematopoietic stem cell scRNA-seq data from Grun et al. (2016)
#' in the form of a \linkS4class{SingleCellExperiment} object with a single matrix of read counts.
#'
#' Rows containing spike-in transcripts are specially labelled with the \code{\link{isSpike}} function.
#' Column metadata contains the extraction protocol used for each sample, as described in GSE76983.
#'
#' @return A \linkS4class{SingleCellExperiment} object.
#'
#' @author Aaron Lun
#'
#' @references
#' Grun D et al. (2016). 
#' De novo prediction of stem cell identity using single-cell transcriptome data. 
#' \emph{Cell Stem Cell} 19(2), 266-277. 
#'
#' @examples
#' sce <- GrunHSCData()
#' 
#' @export
#' @importFrom SingleCellExperiment isSpike<-
#' @importFrom SummarizedExperiment rowData rowData<-
#' @importFrom S4Vectors DataFrame
GrunHSCData <- function(remove.htseq=TRUE) {
    version <- "2.0.0"
    sce <- .create_sce(file.path("grun-hsc", version), has.rowdata=FALSE)

    # Cleaning up the row data.
    symbol <- sub("__.*", "", rownames(sce))
    loc <- sub(".*__", "", rownames(sce))
    rowData(sce) <- DataFrame(symbol=symbol, chr=loc)
    isSpike(sce, "ERCC") <- grep("ERCC-[0-9]+", symbol)

    # Cleaning up the col data.
    cn <- colnames(sce)
    sample <- sub("_.*", "", cn)
    protocol <- ifelse(sample %in% c("JC4", "JC48P2", "JC48P4", "JC48P6", "JC48P7"),
        "sorted hematopoietic stem cells", "micro-dissected cells")
    colData(sce) <- DataFrame(sample=sample, protocol=protocol)

    sce
}