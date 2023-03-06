path_import = function() {
  # default paths
  index_path = fs::path("/Applications/RStudio.app/Contents/Resources/app/www/index.htm")
  gridviewer_path = fs::path("/Applications/RStudio.app/Contents/Resources/app/resources/grid/gridviewer.html")
  css_path = fs::path("/Applications/RStudio.app/Contents/Resources/app/www/rstudio/8F7951420339BE404651DAC70BD1C264.cache.css")
  path_list = list(index = index_path,
                   gridviewer = gridviewer_path,
                   css = css_path)

  # path checks
  for (path in path_list) {
    if (!fs::file_exists(path)) {
      stop(paste0("\n",path, " does not exist. rs.ui can't be activated."), call. = F)
    }
  }

  # return
  return(path_list)
}
