## ----echo=FALSE,results='hide'------------------------------------------------
doAll = FALSE

## ----eval=doAll---------------------------------------------------------------
#  library(Rsamtools)
#  library(GenomicFeatures)
#  library(GenomicAlignments)
#  sampleTable = read.table("bamfiles.txt")
#  dirActualData =  paste(getwd(),"/",sep="")
#  fls = paste(dirActualData,sampleTable[,1],sep="")
#  bamLst = BamFileList(fls, index=character(),yieldSize=100000,obeyQname=TRUE)
#  gtfFile = "gencode.v37.annotation.gtf"
#  txdb = makeTxDbFromGFF(gtfFile, format="gtf")
#  genes = exonsBy(txdb, by="gene")
#  
#  PRJNA693328 = summarizeOverlaps(features = genes, read=bamLst,
#                                  mode="Union",
#                                  singleEnd=FALSE, ## Son lecturas apareadas
#                                  ignore.strand=TRUE,
#                                  fragments=FALSE)

## ---- eval=doAll--------------------------------------------------------------
#  SampleName = c("SAMN08975667", "SAMN08975666", "SAMN08975665", "SAMN08975664","SAMN08975663","SAMN08975662", "SAMN08975661", "SAMN08975660")
#  Run = c("SRR7059136", "SRR7059137", "SRR7059138", "SRR7059139", "SRR7059140", "SRR7059141", "SRR7059142", "SRR7059143")
#  
#  CD8_Status= c(0,1,0,1,0,1,0,1)
#  CD8_Status = factor(CD8_Status,levels=0:1,labels=c("CD39-", "CD39+"))
#  colData(PRJNA693328) = DataFrame(SampleName, Run, CD8_Status)
#  colData(PRJNA693328)

## ---- eval=doAll--------------------------------------------------------------
#  metadata(PRJNA693328)=list("Experimenter name"="Kaibo Duan",
#                             "Contact"="duan_kaibo@immunol.a-star.edu.sg",
#                             "Organization"="Singapore Immunology Network",
#                             "Title"="Bystander CD8 + T cells are abundant and phenotypically distinct in human tumour infiltrates",
#                             "URL"="https://pubmed.ncbi.nlm.nih.gov/29769722/",
#                             "Abstract"= "Various forms of immunotherapy, such as checkpoint blockade immunotherapy, are proving to be effective at restoring T cell-mediated immune responses that can lead to marked and sustained clinical responses, but only in some patients and cancer types. Patients and tumours may respond unpredictably to immunotherapy partly owing to heterogeneity of the immune composition and phenotypic profiles of tumour-infiltrating lymphocytes (TILs) within individual tumours and between patients5,6. Although there is evidence that tumour-mutation-derived neoantigen-specific T cells play a role in tumour control, in most cases the antigen specificities of phenotypically diverse tumour-infiltrating T cells are largely unknown. Here we show that human lung and colorectal cancer CD8+ TILs can not only be specific for tumour antigens (for example, neoantigens), but also recognize a wide range of epitopes unrelated to cancer (such as those from Epstein-Barr virus, human cytomegalovirus or influenza virus). We found that these bystander CD8+ TILs have diverse phenotypes that overlap with tumour-specific cells, but lack CD39 expression. In colorectal and lung tumours, the absence of CD39 in CD8+ TILs defines populations that lack hallmarks of chronic antigen stimulation at the tumour site, supporting their classification as bystanders. Expression of CD39 varied markedly between patients, with some patients having predominantly CD39- CD8+ TILs. Furthermore, frequencies of CD39 expression among CD8+ TILs correlated with several important clinical parameters, such as the mutation status of lung tumour epidermal growth factor receptors. Our results demonstrate that not all tumour-infiltrating T cells are specific for tumour antigens, and suggest that measuring CD39 expression could be a straightforward way to quantify or isolate bystander T cells.")

## ----eval=doAll---------------------------------------------------------------
#  library(AnnotationDbi)
#  library(org.Hs.eg.db)
#  
#  # No funciona sin quitar lo que va después del punto nuestra tabla original
#  tmp=gsub("\\..*","",row.names(PRJNA693328))
#  row.names(PRJNA693328)=tmp
#  
#  a = AnnotationDbi::select(org.Hs.eg.db,keys=rownames(PRJNA693328),columns=c("GENENAME","ENTREZID","ENSEMBL","SYMBOL"),keytype="ENSEMBL")
#  b = match(rownames(PRJNA693328),a[,"ENSEMBL"])
#  rowData(PRJNA693328) = a[b,]
#  rowData(PRJNA693328)
#  PRJNA693328 = PRJNA693328[which(!is.na(rowData(PRJNA693328)[,"ENSEMBL"])),]
#  PRJNA693328
#  sel = match(unique(rowData(PRJNA693328)[,"ENSEMBL"]),rowData(PRJNA693328)[,"ENSEMBL"])
#  PRJNA693328 = PRJNA693328[sel,]
#  #Eliminamos los genes que no tienen ninguna lectura alineada.
#  #Podríamos utilizar criterios más restrictivos en posteriores pasos del análisis.
#  nullsum = apply(assay(PRJNA693328),1,sum)==0
#  nullsum
#  PRJNA693328 = PRJNA693328[!nullsum,]

## ----eval=doAll---------------------------------------------------------------
#  save(PRJNA693328,file="PRJNA693328.rda")

