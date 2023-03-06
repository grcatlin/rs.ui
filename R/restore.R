restore = function(path) {
  # get parent directory
  parent = dirname(path)

  # backup directory
  dir = fs::path_join(c(parent, "rs.ui"))

  # backup name
  backup_name = fs::path_file(path)
  backup_name_bits = unlist(strsplit(backup_name, ".", fixed=T))
  backup_name_bits[length(backup_name_bits) - 1] = paste0(backup_name_bits[length(backup_name_bits) - 1], "_backup")
  backup_name = paste0(backup_name_bits, collapse = ".")

  # backup path
  backup_path = fs::path_join(c(dir, backup_name))

  # if backup exists, restore original file and remove rs.ui contents
  if (!fs::file_exists(backup_path)) {
    stop(paste0(
      "Backup file not found. Can't restore."
    ), call. = F)
  }

  # restore
  fs::file_copy(backup_path, path, overwrite = TRUE)
  fs::dir_delete(dir)

  # rstheme
  rstudioapi::applyTheme("Pastel On Dark")

  # if rs.ui theme exists
  if ("rs.ui" %in% names(rstudioapi::getThemes())) {
    rstudioapi::removeTheme("rs.ui")
  }
}
