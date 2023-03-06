rainbow_gen = function(main_color) {
  rgb_col = grDevices::col2rgb(main_color)
  hsv_col = grDevices::rgb2hsv(rgb_col)[,1]
  cols = seq(hsv_col[1], hsv_col[1] + 1, by=1/7)[1:7]
  cols = ifelse(cols > 1, cols - 1, cols)
  colors = grDevices::hsv(cols, hsv_col[2], hsv_col[3])
  # transparency
  if (substr(main_color, 1, 1) == "#" && nchar(main_color) == 9) {
    alpha = substr(main_color, 8, 9)
    colors = paste(colors, alpha, sep="")
  }
  return(rev(colors))
}

color_gen = function(main_color, value, tint) {
  # convert to rgb
  rgb_col = grDevices::col2rgb(main_color)[,1]

  # tint
  tint_calc = function(color) {
    color = color + ((255 - color) * value)
    return(color)
  }

  # shade
  shade_calc = function(color) {
    color = color * (1 - value)
    return(color)
  }

  # calculate new rgb
  if (tint) {
    new = sapply(rgb_col, tint_calc)
  } else {
    new = sapply(rgb_col, shade_calc)
  }

  # convert to hex
  new = rgb(new[1], new[2], new[3], maxColorValue = 255)
  return(new)
}

closest_color = function(cols, wanted_color) {
  # convert to rgb
  wanted_rgb = grDevices::col2rgb(wanted_color)
  col_rgb = grDevices::col2rgb(cols)

  # calculate distance
  distance = sqrt(sum((col_rgb - c(wanted_rgb))^2))
  distance = (col_rgb - c(wanted_rgb))^2
  distance = apply(distance, 2, sum)
  distance = sqrt(distance)

  # pick which minimizes & return
  index = which.min(distance)
  return(cols[index])
}

invert_color = function(color) {
  # convert to rgb
  rgb_col = grDevices::col2rgb(color)[,1]

  # invert
  inverted = 255-rgb_col

  # convert to hex
  inverted = rgb(inverted[1], inverted[2], inverted[3], maxColorValue = 255)
  return(inverted)
}
