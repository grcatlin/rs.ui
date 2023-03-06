write_css = function(file, path) {
  # parent
  parent = dirname(path)

  # backup directory
  dir = fs::path_join(c(parent, "rs.ui"))

  # write file
  file_path = fs::path(paste0(dir,"/theme.css"))
  writeLines(file, file_path)
}

write_rstheme = function(file) {
  # create temp file & write
  writeLines(file, "tmp.rstheme")

  # add to RStudio & Apply
  rstudioapi::applyTheme("Pastel On Dark")

  # if rs.ui theme exists
  if ("rs.ui" %in% names(rstudioapi::getThemes())) {
    rstudioapi::removeTheme("rs.ui")
  }

  # add theme
  suppressWarnings(rstudioapi::addTheme("tmp.rstheme", force = T))
  rstudioapi::applyTheme("rs.ui")

  # remove temp
  unlink("tmp.rstheme")
}
