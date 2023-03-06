template_edit = function(file, dat) {
  for (element in dat$ELEMENT) {
    str = paste0(element, ": COL;")
    new_str = stringr::str_replace(str, "COL", dat[ELEMENT == element]$COLOR)
    file = stringr::str_replace(file, str, new_str)
  }
  return(file)
}
