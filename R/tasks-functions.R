 
#' Trapezoid rule for numerical integration 
#' @description 
#' An implementation of the trapezoid rule for numerical integration
#' @param x Abscisas
#' @param y Function values at \code{x}
#' 
TrapezoidRule = function(x,y){
  idx = 2:length(x)
  return (as.double( (x[idx] - x[idx-1]) %*% (y[idx] + y[idx-1])) / 2)
}

#' URL's from entrez identifiers
#' @description  
#' It makes the url's from entrez identifiers
#' @param id ENTREZ identifiers
#' @return 
#' The corresponding URL's in the database 
#' @export
#' @family URL generation
entrezid2url = function(id)
  ifelse(id == "NA",NA,
         paste("<a href='http://www.ncbi.nlm.nih.gov/gene/?term=",
                            id,"'>",id,"</a>",sep=""))
