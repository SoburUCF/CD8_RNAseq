# Required Libraries

library(DESeq2)
library(tidyverse)
library(ggalt)
library(ggrepel)
library(pheatmap)
library(RColorBrewer)
library(BiocGenerics)
library(org.Mm.eg.db)
library(AnnotationDbi)
library(EnhancedVolcano)
library(clusterProfiler)
library(enrichplot)

# Data Import -Import Count data from data directory

Counts <- read.delim("data/counts_matrix.csv", header = TRUE, row.names = 1, sep = ",")
Counts <- select(Counts, -GeneSymbol)
Counts <- Counts[rowSums(Counts) > 50, ]


# Metadata creation
# Define condition as a factor
condition <- factor(c(rep("Blood", 4), rep("Fat", 2), rep("IEL", 3), 
                      rep("Kidney", 3), rep("Liver", 2), rep("SG", 3), rep("Spleen", 5)))

# Create metadata dataframe
coldata <- data.frame(condition = condition, row.names = colnames(Counts))

# Ensure that rownames of coldata match colnames of Counts
all(colnames(Counts) %in% rownames(coldata))  


# create a DESeqDataSet

dds <- DESeqDataSetFromMatrix(countData = Counts,
                              colData = coldata,
                              design = ~ condition) 

# Normalization
dds <- DESeq(dds)

# Dispersion plot
plotDispEsts(dds, main="Dispersion plot")

#Quality control
rld <- rlog(dds, blind = FALSE)

# PCA plot
plotPCA(rld, intgroup = "condition")

# Heatmap
rld_mat <- assay(rld) 
rld_cor <- cor(rld_mat)   
pheatmap(rld_cor)



################
# Expression of IEL compared to spleen
################################

res <-  results (dds, contrast  = c("condition", "IEL", "Spleen"))



de_genes <- res[abs(res$log2FoldChange) > 5 & !is.na(res$padj) & res$padj < 0.05, ]
selected_genes <- rownames(de_genes)
heatmap_data <- assay(rld)[selected_genes, ]
