init_checks = function(theme_def, main_color) {
  # Fail quickly if the RStudio API is not available
  if (!rstudioapi::isAvailable()) {
    stop("RStudio must be running in order to run rs.ui.", call. = F)
  }

  # Print message about compatibility with other RStudio versions
  rs_version = rstudioapi::versionInfo()$version
  if (rs_version != "2023.3.0.386") {
    msg <- paste0(
      "rs.ui was built for RStudio 2023.3.0.386 but this is RStudio ",
      rs_version,
      ".\n\n",
      "UI elements may not look as expected as there is typically a breaking ",
      "change with each RStudio release.\n\n",
      "If you are able to find and fix a broken element, please contact me ",
      "via rs.ui's Github. Any help is appreciated! ︎😇"
    )
    warning(msg, call. = F)
  }

  # Check OS
  os <- Sys.info()[["sysname"]]
  if (os != "Darwin") {
    msg = paste0(
      "\nrs.ui is only built for MacOS at this time. However, I am open to ",
      "adding support for Windows and/or Linux if it is highly requested.\n\n",
      "Reach out to me via rs.ui's Github if this is something you'd like to see! 💌"
    )
    stop(msg, call. = F)
  }

  # Is a theme def or main color supplied?
  if (is.null(theme_def) && is.null(main_color)) {
    msg = paste0("\nrs.ui requires a theme_def or a main_color.")
    stop(msg, call. = F)
  }


  # Are both theme and main color defined?
  if (!is.null(theme_def) && !is.null(main_color)) {
    message(is.null(theme_def))
    msg = paste0("\nEither an exact theme defintion or a main color can be supplied, but not both.")
    stop(msg, call. = F)
  }

  # theme_def check
  if (!is.null(theme_def)) {

    # colnumn names
    if (!all.equal(colnames(theme_def), colnames(theme_def_example))) {
      stop("theme_def should have 2 columns: 'ELEMENT' and 'COLOR'. This is to maintain sharability.",
           call. = F)
    }

    # unknown element specification
    unknown_elements = which(!(theme_def$ELEMENT %in% theme_def_example$ELEMENT))
    unknown_elements = theme_def[unknown_elements]$ELEMENT
    if (length(unknown_elements) > 0) {
      msg = paste0("Element(s) [", paste0(unknown_elements, collapse = ", "),"] ",
                   "in your theme_def are not used. View rs.ui::example_theme",
                   " for the exact theme specification rs.ui requires.")
      stop(msg, call. = F)
    }

    # missing elements
    missing_elements = which(!(theme_def_example$ELEMENT %in% theme_def$ELEMENT))
    missing_elements = theme_def_example[missing_elements]$ELEMENT
    if (length(missing_elements) > 0) {
      msg = paste0("Element(s) [", paste0(missing_elements, collapse = ", "),"] ",
                   "are missing from your theme_def. View rs.ui::example_theme",
                   " for the exact theme specification rs.ui requires.")
      stop(msg, call. = F)
    }
  }
}
