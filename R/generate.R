generate = function(main_color, theme_def) {
  # read in templates
  grid_path = fs::path(fs::path_package(package = "rs.ui"), "resources/grid_template.css")
  main_path = fs::path(fs::path_package(package = "rs.ui"), "resources/theme_template.css")
  editor_path = fs::path(fs::path_package(package = "rs.ui"), "resources/editor_template.rstheme")
  grid = readLines(grid_path)
  main = readLines(main_path)
  editor = readLines(editor_path)

  # if only main_color
  if (!is.null(main_color)) {
    # internal df
    theme = data.table::as.data.table(theme_def_example)

    ##### editor #####

    # editor bg
    theme[ELEMENT == "editor-bg", COLOR := color_gen(main_color, .7, F)]
    theme[ELEMENT == "editor-gutter-bg", COLOR := color_gen(main_color, .7, F)]

    # editor text
    theme[ELEMENT == "editor-text", COLOR := color_gen(main_color, .85, T)]
    theme[ELEMENT == "editor-gutter-text", COLOR := "#FFFFFF40"]

    # editor highlight
    theme[ELEMENT == "editor-highlight", COLOR := "#FFFFFF40"]

    # editor rainbow parentheses
    rainbows = rainbow_gen(main_color)
    theme[stringr::str_detect(ELEMENT, "rain"), COLOR := rainbows]

    # keyword, constant, string
    theme[ELEMENT == "editor-keyword", COLOR := main_color]
    theme[ELEMENT == "editor-constant", COLOR := closest_color(rainbows, "orange")]
    theme[ELEMENT == "editor-string", COLOR := closest_color(rainbows, "green")]

    # editor fold
    theme[ELEMENT == "editor-fold", COLOR := closest_color(rainbows, "cyan")]

    # editor comment
    theme[ELEMENT == "editor-comment", COLOR := color_gen(main_color, .25, T)]

    ##### main ui #####

    # autocomplete, active tab
    theme[ELEMENT == "main-autocomplete-fg", COLOR := main_color]
    theme[ELEMENT == "main-active-tab", COLOR := main_color]

    # inactive
    theme[ELEMENT == "main-inactive-tab", COLOR := color_gen(main_color, .2, F)]

    # ui bg
    theme[ELEMENT == "main-ui-bg", COLOR := color_gen(main_color, .85, F)]

    # button
    theme[ELEMENT == "main-ui-button-bg", COLOR := color_gen(main_color, .2, F)]

    ##### grid #####

    # grid bars
    theme[ELEMENT == "grid-bars", COLOR := paste0(main_color, 75)]
    theme[ELEMENT == "grid-selected-bars", COLOR := main_color]

    # grid bg
    theme[ELEMENT == "grid-bg", COLOR := color_gen(main_color, .7, F)]

    # grid highlight
    theme[ELEMENT == "grid-highlight", COLOR := "#FFFFFF40"]
  } else {
    theme = theme_def
  }

  # get names in format used
  theme[, ELEMENT := paste0("--theme-", ELEMENT)]

  # split into main, editor, grid css files
  main_key = theme[stringr::str_detect(ELEMENT, "main")]
  grid_key = theme[stringr::str_detect(ELEMENT, "grid")]
  editor_key = theme[stringr::str_detect(ELEMENT, "editor")]

  # match and replace
  main = template_edit(main, main_key)
  grid = template_edit(grid, grid_key)
  editor = template_edit(editor, editor_key)
  return(list(main = main, grid = grid, editor = editor, theme = theme))
}
