
# This script automates the the process of passing html files into the jekyll system. Its done for the handbook for infectious diseases


# This command lists all zip files 
zipfiles <- list.files(".", pattern = ".zip$")

# These commands remove all old files
file.remove(list.files(".", pattern = ".html$"))
file.remove(list.files(".", pattern = ".png$"))


for (a in zipfiles) {
# a <- zipfiles[2]

# Getting the necessary information out of the zip-file name
name_separted <- strsplit(a, "\\.")[[1]]
name_separted <- strsplit(name_separted[1], "-")[[1]]
name_separted_blanks <- paste(name_separted[2:length(name_separted)], collapse = " ")
name_separted_underscore <- paste(name_separted[2:length(name_separted)], collapse = "_")
newfilename <- paste0("../docs/",name_separted_underscore,".html")
number <- strsplit(name_separted[1], split = "(?<=[a-zA-Z])\\s*(?=[0-9])", perl = TRUE)[[1]][[2]]
number <- sub("^0+", "", number)



# Unzip the file
unzip(a)


# Get rid of the annoying error 
write("\n", "document.html", append = T)


# Remove html head and css from document.html
document <- readLines("document.html") 
start <- grep("<div class=\"article-part article-richtext article-body\">", document) + 1
finish <- grep("</body", document) - 1
document <- document[start:finish]
# write(document[start:finish], file = "test.html")


if(file.exists(newfilename)) file.remove(newfilename)

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
file.remove(list.files(".", pattern = ".html$"))
file.remove(list.files(".", pattern = ".zip$"))








