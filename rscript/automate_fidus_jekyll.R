
# This script automates the the process of passing html files 
# into the jekyll system. Its done for the handbook for infectious diseases


# This command lists all zip files 
zipfiles <- list.files(".", pattern = ".zip$")

# loop through all zip files
for (a in zipfiles) {

# Getting the necessary information out of the zip-file name
name_separted <- strsplit(a, "\\.")[[1]]
name_separted <- strsplit(name_separted[1], "-")[[1]]
name_separted_blanks <- paste(name_separted[2:length(name_separted)], collapse = " ")
name_separted_blanks <- paste0(toupper(substr(name_separted_blanks, 1, 1)), substr(name_separted_blanks, 2, nchar(name_separted_blanks)))
name_separted_underscore <- paste(name_separted[2:length(name_separted)], collapse = "_")
newfilename <- paste0("../docs/",name_separted_underscore,".html")
number <- strsplit(name_separted[1], split = "(?<=[a-zA-Z])\\s*(?=[0-9])", perl = TRUE)[[1]][[2]]
number <- sub("^0+", "", number)


# Unzip the file
unzip(a)


# Get rid of the annoying error of a missing newline
write("\n", "document.html", append = T)

# Remove html head and css from document.html
document <- readLines("document.html") 
start <- grep("<div class=\"article-part article-richtext article-body\">", document) + 1
finish <- grep("</body", document) - 1
document <- document[start:finish]
# write(document[start:finish], file = "test.html")

# remove the old file if it exists
if(file.exists(newfilename)) file.remove(newfilename)

# the new file is created line by line. This is where the jekyll front matter is included
write("---", newfilename)
write("layout: page", file = newfilename, append = T)
write(paste("title:", name_separted_blanks), newfilename, append = T)
write(paste("nav_order:", number), newfilename, append = T)
write("---", newfilename, append = T)
write(document, newfilename, append = T)


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

