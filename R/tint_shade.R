#' Tints or Shades a Color
#' @usage
#' tint.this("#7cb7a3", .15)
#' @param color A valid color specification as either a hex code or name.
#' @param value A value between 0 and 1. This is the percentage the supplied color
#'   is shifted by.
#' @examples
#' rs.ui(main_color = tint.this("#3d2b56"))
#' rs.ui(main_color = shade.this("#ae2573", .25))
#' @export

tint.this = function(color = NULL, value = .10) {
  # catch
  if (is.null(color)) {
    stop("A color to tint must be supplied.", call. = F)
  }
  if (value < 0 | value > 1) {
    stop("The value must be between [0,1].", call. = F)
  }

  # convert to rgb
  color = grDevices::col2rgb(color)[,1]

  # tint calculation
  tint_calc = function(color) {
    color = color + ((255 - color) * value)
    return(color)
  }

  # apply tint calc
  color = sapply(color, tint_calc)

  # convert to hex
  color = rgb(color[1], color[2], color[3], maxColorValue = 255)
  return(color)
}

#' @rdname tint.this
#' @usage
#' shade.this("#7cb7a3", .20)
#' @export

shade.this = function(color = NULL, value = .10) {
  # catch
  if (is.null(color)) {
    stop("A color to shade must be supplied.", call. = F)
  }
  if (value < 0 | value > 1) {
    stop("The value must be between [0,1].", call. = F)
  }

  # convert to rgb
  color = grDevices::col2rgb(color)[,1]

  # shade calc
  shade_calc = function(color) {
    color = color * (1 - value)
    return(color)
  }

  # apply shade calc
  color = sapply(color, shade_calc)

  # convert to hex
  color = rgb(color[1], color[2], color[3], maxColorValue = 255)
  return(color)
}
