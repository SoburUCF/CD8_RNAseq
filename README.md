# CD8_RNAseq

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

Repository of tissue resident CD8 T cell RNA seq data analysis

Count data was collected from the publication by Crowl et al. 2022
https://www.nature.com/articles/s41590-022-01229-8 

Bulk RNA sequencing raw gene count data was collected from https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE182274




### RNA seq alignment

Using Hisat2 : https://github.com/DaehwanKimLab/hisat2

```
#This will download the human reference genome and annotation file from UCSC website
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
wget https://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/genes/hg38.ensGene.gtf.gz
gunzip *.gz

#Index the ref genome
hisat2-build hg38.fa hg38_index
```
