## ----include=FALSE------------------------------------------------------------
doAll = FALSE

## ----LoadLibraries,warnings=FALSE, message=FALSE------------------------------
library(Biobase)
library(GEOquery)
library(affy)
library(hgu133plus2.db)
library(AnnotationDbi)

## ----DownloadData, eval=doAll-------------------------------------------------
#  
#  files <- GEOquery::getGEOSuppFiles("GSE19804")
#  system("tar xvf GSE19804/GSE19804_RAW.tar")
#  # Procesamos los ficheros cel y creamos un objeto AffyBatch de nombre "datossinnorm"
#  datossinnorm = ReadAffy()
#  system("rm -fr GSE19804")
#  system("rm *CEL.gz")
#  

## ---- eval=FALSE--------------------------------------------------------------
#  affy::MAplot

## ----eval = doAll-------------------------------------------------------------
#  affy::MAplot(datossinnorm)

## ----eval = doAll-------------------------------------------------------------
#  affy::hist(datossinnorm)

## ----eval = doAll-------------------------------------------------------------
#  affy::boxplot(datossinnorm,col="blue",
#          main="Diagrama de cajas preprocesamiento",
#          ylab="Intensidad en log2",
#          xlab="Muestras", names=FALSE)

## ----normalization, warning=FALSE, message=FALSE, eval=doAll------------------
#  datosnorm <- affy::rma(datossinnorm)

## ---- eval=doAll--------------------------------------------------------------
#  matrizexpr = exprs(datosnorm)

## ----eval = doAll-------------------------------------------------------------
#  affy::MAplot(datosnorm)

## ----eval = doAll-------------------------------------------------------------
#  affy::hist(datosnorm)

## ----eval = doAll-------------------------------------------------------------
#  affy::boxplot(datosnorm,col="orange",
#          main="Diagrama de cajas postprocesado",
#          ylab="Intensidad en log2",
#          xlab="Muestras", names=FALSE)

## ----metadata, eval=doAll-----------------------------------------------------
#  infoData = new('MIAME',
#          name='Tzu-Pin Lu',
#          lab='National Taiwan University, Taiwan',
#          contact ='tplu@ntu.edu.tw',
#                       url ="https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19804",
#               pubMedIds =c("20802022","25889623"),
#               title = " 	Genome-wide screening of transcriptional modulation in non-smoking female
#          lung cancer in Taiwan",
#               abstract = "Although smoking is the major risk factor for lung cancer, only 7% of female
#               lung cancer patients in Taiwan have a history of cigarette smoking, extremely
#               lower than those in Caucasian females.
#          This report is a comprehensive analysis of the molecular signature of
#          non-smoking female lung cancer in Taiwan.")
#  
#  finput = system.file("externaldata","atributos.csv", package = "carlosmarrero")
#  pd0 = read.csv(finput, header=TRUE, row.names = 1)
#  metadatos = data.frame(labelDescription = colnames(pd0),row.names=colnames(pd0))
#  datosfenotipo = new("AnnotatedDataFrame", data = pd0, varMetadata = metadatos)
#  geod19804  = new("ExpressionSet",
#                  exprs=matrizexpr,
#                  phenoData = datosfenotipo,
#                  experimentData = infoData,
#                  annotation='hgu133plus2')

## ----eval=doAll---------------------------------------------------------------
#  a = AnnotationDbi::select(hgu133plus2.db::hgu133plus2.db,keys=featureNames(geod19804),
#                            column=c("ENTREZID","ENSEMBL","GENENAME"),keytype="PROBEID")
#  a = a[!is.na(a[,"ENTREZID"]),]
#  b = match(featureNames(geod19804),a[,"PROBEID"])
#  fData(geod19804) = a[b,]
#  dim(geod19804)
#  fData(geod19804)
#  save(geod19804,file="geod19804.rda")

