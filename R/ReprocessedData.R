#' Reprocessed single-cell data sets
#'
#' Obtain the legacy count matrices for three publicly available single-cell RNA-seq datasets.
#' Raw sequencing data were downloaded from NCBI's SRA or from EBI's ArrayExpress,
#' aligned to the relevant genome build and used to quantify gene expression.
#'
#' @return
#' A \linkS4class{SingleCellExperiment} object containing one or more expression matrices,
#' column metadata and (possibly) spike-in information.
#' 
#' @details
#' \code{ReprocessedFluidigmData} returns a dataset of 65 cells from Pollen et al. (2014), 
#' each sequenced at high and low coverage (SRA accession SRP041736).
#' 
#' \code{ReprocessedTh2Data} returns a dataset of 96 T helper cells from Mahata et al. (2014),
#' obtained from ArrayExpress accession E-MTAB-2512.
#' This will contain spike-in information labelled with \code{\link{isSpike}}.
#'
#' \code{ReprocessedAllenData} return a dataset of 379 cells from Tasic et al. (2016).
#' This is a re-processed subset of the data from \code{\link{TasicBrainData}},
#' It also contains spike-in information labelled with \code{\link{isSpike}}.
#'
#' In each dataset, the first columns of the \code{colData} are sample quality metrics from FastQC and Picard.
#' The remaining fields were obtained from the original study in their GEO/SRA submission
#' and/or as Supplementary files in the associated publication.
#' These two categories of \code{colData} are distinguished by a \code{which_qc} element in the \code{\link{metadata}},
#' which contains the names of the quality-related columns in each object.
#' 
#' @section Pre-processing details:
#' FASTQ files were either obtained directly from ArrayExpress, 
#' or converted from SRA files (downloaded from the Sequence Read Archive) using the SRA Toolkit.
#'
#' Reads were aligned with TopHat (v. 2.0.11) to the appropriate reference genome (GRCh38 for human samples, GRCm38 for mouse). 
#' RefSeq mouse gene annotation (GCF_000001635.23_GRCm38.p3) was downloaded from NCBI on Dec. 28, 2014. 
#' RefSeq human gene annotation (GCF_000001405.28) was downloaded from NCBI on Jun. 22, 2015.
#'
#' featureCounts (v. 1.4.6-p3) was used to compute gene-level read counts.
#' Cufflinks (v. 2.2.0) was used to compute gene-leve FPKMs.
#' Reads were also mapped to the transcriptome using RSEM (v. 1.2.19) to compute read counts and TPM's.
#' 
#' FastQC (v. 0.10.1) and Picard (v. 1.128) were used to compute sample quality control (QC) metrics. 
#' However, no filtering on the QC metrics has been performed for any dataset.
#'
#' @references
#' Pollen AA et al. (2014). 
#' Low-coverage single-cell mRNA sequencing reveals cellular heterogeneity and activated signaling pathways in developing cerebral cortex. 
#' \emph{Nat. Biotechnol.} 32(10), 1053-8.
#'
#' Mahata B et al. (2014).
#' Single-cell RNA sequencing reveals T helper cells synthesizing steroids de novo to contribute to immune homeostasis. 
#' \emph{Cell Rep}, 7(4), 1130-42.
#'
#' Tasic A et al. (2016). 
#' Adult mouse cortical cell taxonomy revealed by single cell transcriptomics.
#' \emph{Nat. Neurosci.} 19(2), 335-46.
#'
#' @export
#' @rdname ReprocessedData
#' @importFrom SingleCellExperiment isSpike
ReprocessedAllenData <- function() {
    version <- "1.10.0"
    sce <- .create_sce_legacy(file.path("legacy-allen", version))
    isSpike(sce, "ERCC") <- grep("^ERCC-[0-9]+$", rownames(sce))
    sce
}

#' @export
#' @rdname ReprocessedData
#' @importFrom SingleCellExperiment isSpike
ReprocessedTh2Data <- function() {
    version <- "1.10.0"
    sce <- .create_sce_legacy(file.path("legacy-th2", version))
    isSpike(sce, "ERCC") <- grep("^ERCC-[0-9]+$", rownames(sce))
    sce
}

#' @export
#' @rdname ReprocessedData
#' @importFrom SingleCellExperiment isSpike
ReprocessedFluidigmData <- function() {
    version <- "1.10.0"
    .create_sce_legacy(file.path("legacy-fluidigm", version))
}