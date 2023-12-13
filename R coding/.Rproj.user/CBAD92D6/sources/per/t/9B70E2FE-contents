# folder with 1000s of PDFs
dest <- "C:/Users/majewska/Documents/GitHub/syllabus-review-project/syllabi/words/PDFs"

# make a vector of PDF file names
myfiles <- list.files(path = dest, pattern = "pdf",  full.names = TRUE)

# convert each PDF file that is named in the vector into a text file 
# text file is created in the same directory as the PDFs
# note that my pdftotext.exe is in a different location to yours
lapply(myfiles, function(i) system(paste('"C:/Program Files/Glyph & Cog/xpdf-tools-win-4.04/bin64/pdftotext.exe"', 
                                         paste0('"', i, '"')), wait = FALSE) )