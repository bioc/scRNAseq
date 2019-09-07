#' Obtain the Messmer ESC data
#'
#' Obtain the human embryonic stem cell single-cell RNA-seq data from Messmer et al. (2019).
#'
#' @details
#' Row data contains a single \code{"Length"} field describing the total exonic length of each feature.
#'
#' Column metadata is provided in the same form as supplied in E-MTAB-6819.
#' This contains information such as the cell phenotype (naive or primed) and the batch of origin.
#' Note that counts for technical replicates have already been summed together,
#' so there is no longer a 1:1 mapping between the columns here and the entries of E-MTAB-6819.
#'
#' ERCC spike-ins are stored as an alternative experiment.
#'
#' All data are downloaded from ExperimentHub and cached for local re-use.
#' Specific resources can be retrieved by searching for \code{scRNAseq/messmer-esc}.
#' 
#' @return A \linkS4class{SingleCellExperiment} object with a single matrix of read counts.
#'
#' @author Aaron Lun 
#'
#' @references
#' Messmer T et al. (2019). 
#' Transcriptional heterogeneity in naive and primed human pluripotent stem cells at single-cell resolution. 
#' \emph{Cell Rep} 26(4), 815-824.e4
#'
#' @examples
#' sce <- MessmerESCData()
#' 
#' @export
#' @importFrom SingleCellExperiment splitAltExps
MessmerESCData <- function() {
    version <- "2.0.0"
    sce <- .create_sce(file.path("messmer-esc", version))
    spike.type <- ifelse(grepl("ERCC", rownames(sce)), "ERCC", "endogenous")
    splitAltExps(sce, spike.type, ref="endogenous")
}