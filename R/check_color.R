check_color = function(color) {
  # color check function
  valid_col = function(color) {
    res <- try(grDevices::col2rgb(color), silent = TRUE)
    return(!"try-error" %in% class(res))
  }

  # 3 digit hex to full
  short_to_full = function(color) {
    color = stringr::str_replace(color, "#", "")
    color = unlist(strsplit(color, ""))
    color = unlist(lapply(color, rep, 2))
    color = paste0("#", paste0(color, collapse = ""))
    return(color)
  }

  # convert 3 digit to full
  if (stringr::str_detect(color, "#")) {
    if (stringr::str_length(color) == 4) {
      color = short_to_full(color)
    }
  }

  # check color
  if (!valid_col(color)) {
    msg = paste0('"', color, '" is not a valid hex code or color string. ')

    if (!is.null(main_color)) {
      msg = paste0(msg, 'Check your main_color.')
    } else {
      which_err = subset(theme_def, COLOR == color)[, 1]
      msg = paste0(msg, "the element corresponding to this error in your ",
                   "specified theme_def is ", which_err)
    }
    stop(msg,call. = F)
  }

  return(color)
}
check_color = Vectorize(check_color, USE.NAMES = F)
