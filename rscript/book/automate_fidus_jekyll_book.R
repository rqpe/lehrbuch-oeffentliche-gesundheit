
# This script automates the the process of passing html files 
# into the jekyll system. Its done for the handbook for infectious diseases


# Unzip the file
unzip("book/lehrbuch-ffentlicher-gesundheitsdienst.html.zip", exdir = "book")

# This command lists all html files 
htmlfiles <- list.files("book/.", pattern = ".html$")

# loop through all zip files
for (a in htmlfiles) {

a <- htmlfiles[1]  

# Get rid of the annoying error of a missing newline
write("\n", paste0("book/", a), append = T)

# Getting the necessary information out of the html-file
number <- strsplit(strsplit(a, "\\.")[[1]][1], "-")[[1]][2]
nefilename <- paste0("ready", a)

# read in the document
document <- readLines(paste0("book/", a))

# Get document title
title_line <- document[grep("<title", document)]
title <- strsplit(strsplit(title_line, ">")[[1]][2], "<")[[1]][1]

# Get content out of document
document <- document[grep("<div class=\"article-part article-richtext article-body\">", document) ][1]

# remove the old file if it exists
if(file.exists(newfilename)) file.remove(newfilename)




  
  

number <- strsplit(name_separted[1], split = "(?<=[a-zA-Z])\\s*(?=[0-9])", perl = TRUE)[[1]][[2]]
number <- sub("^0+", "", number)





# the new file is created line by line. This is where the jekyll front matter is included
write("---", newfilename)
write("layout: page", file = newfilename, append = T)
write(paste("title:", name_separted_blanks), newfilename, append = T)
write(paste("nav_order:", number), newfilename, append = T)
write("---", newfilename, append = T)
write(document, newfilename, append = T)








<details markdown="block">
  <summary>
  CONTENTS
</summary>
  ____
- TOC
{:toc}
____
</details>
  



file.remove("document.html")

}

# Copying all pictures to the docs folder
pics <- list.files(".", pattern = ".png$")
for (i in pics) {
  file.copy(i, paste0("../docs/", i))
}

# Cleaning up
file.remove(list.files(".", pattern = ".png$"))
file.remove(list.files(".", pattern = ".woff$"))

