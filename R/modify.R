modify = function(path) {
  # file name
  file_name = fs::path_file(path)

  # read file
  to_mod = readLines(path)

  # modify
  switch(
    file_name,
    "8F7951420339BE404651DAC70BD1C264.cache.css" = {
      stringr::str_replace(to_mod,
                           "outline: #8AA9DB solid 2px !important",
                           "outline: #8AA9DB solid 2px")
    },
    "index.htm" = {
      line_n = stringr::str_which(to_mod,
                                  "  <link type=\"text/css\" rel=\"stylesheet\" href=\"css/icons.css\" />")
      before = to_mod[1:line_n]
      inject = "  <link type=\"text/css\" rel=\"stylesheet\" href=\"rs.ui/theme.css\" />"
      after = to_mod[(line_n + 1):length(to_mod)]
      to_mod = c(before, inject, after)
    },
    "gridviewer.html" = {
      line_n = stringr::str_which(to_mod,
                                  "    <link rel=\"stylesheet\" href=\"dtstyles.css\" />")
      before = to_mod[1:line_n]
      inject = "    <link type=\"text/css\" rel=\"stylesheet\" href=\"rs.ui/theme.css\" />"
      after = to_mod[(line_n + 1):length(to_mod)]
      to_mod = c(before, inject, after)
    }
  )

  # save changes
  writeLines(to_mod, con = path)
}
