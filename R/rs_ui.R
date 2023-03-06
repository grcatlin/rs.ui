#' rs.ui
#'
#' @param theme_def A data.frame specifying a theme in the form of rs.ui::example_theme.
#' @param main_color A valid color specification as either a hex code or name.
#' @param restore A logical indicating whether to restore RStudio to its original (unthemed) state.
#' @param export A logical indicating whether to export the generated theme to a shareable .csv file.
#' @description
#' rs.ui modifies RStudio files such that they point to css files rs.ui generates.
#' Doing this allows the UI of RStudio to be customized. rs.ui backs up the un-modded
#' RStudio files such that the original RStudio setup can be restored.
#'
#' rs.ui has two fundamental modes: \code{main_color} and \code{theme_def}.
#'
#' If provided a \code{main_color}, rs.ui generates a custom theme based off this color
#' by calculating tints/shades and analogous colors. If rs.ui generates a theme you enjoy,
#' it can be exported with the export parameter so it can be shared!
#'
#' If provided a valid \code{theme_def}, no generation takes place and rs.ui writes
#' css files according to the provided \code{theme_def}. This option was added to allow
#' finer control and sharing between rs.ui users.
#'
#' At the moment, only MacOS is supported but it is possible to do the same on Windows and/or
#' Linux. With enough support, I can add this functionality.
#'
#' I hope you enjoy this (I think) cool, but mostly useless, project! 💝
#' @examples
#' # generating a theme given a color
#' rs.ui(main_color = "#504066")
#'
#' # importing and using a theme_def specification
#' my_theme = read.csv("my_theme.csv")
#' rs.ui(theme_def = my_theme)
#'
#' # restoring RStudio
#' rs.ui(restore = T)
#'
#' # generating a theme and saving the csv (to modify or share)
#' rs.ui(main_color = "#205d89", export = T)
#' @export

rs.ui <- function(theme_def = NULL, main_color = NULL, restore = F, export = F) {

  # restore
  if (restore) {
    invisible(lapply(path_import(), restore))
    return(message("rs.ui deactivated. Restart RStudio for changes to take effect."))
  }

  # convert theme_def to data.table
  if (!is.null(theme_def)) {theme_def = as.data.table(theme_def)}

  # check RStudio availability, build, OS, theme_def
  init_checks(theme_def, main_color)

  # check for valid colors
  if (!is.null(main_color)) {main_color = check_color(main_color)}
  if (!is.null(theme_def)) {theme_def[, COLOR := check_color(COLOR)]}

  # check and get file paths
  paths = path_import()

  # backup
  invisible(lapply(paths, backup))

  # generate css & rstheme
  mods = generate(main_color, theme_def)

  # write css for grid & main
  write_css(mods$main, paths$index)
  write_css(mods$grid, paths$gridviewer)

  # add rstheme
  write_rstheme(mods$editor)

  # modify
  invisible(lapply(paths, modify))

  # export
  if (export) {
    fwrite(mods$theme, "theme.csv")
    message(paste0("theme.csv was saved in your current working directory: ", getwd()))
  }

  message("Installation successful - please reboot for full effects to be visible.")
}
