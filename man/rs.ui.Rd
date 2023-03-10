% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rs_ui.R
\name{rs.ui}
\alias{rs.ui}
\title{rs.ui}
\usage{
rs.ui(theme_def = NULL, main_color = NULL, restore = F, export = F)
}
\arguments{
\item{theme_def}{A data.frame specifying a theme in the form of rs.ui::example_theme.}

\item{main_color}{A valid color specification as either a hex code or name.}

\item{restore}{A logical indicating whether to restore RStudio to its original (unthemed) state.}

\item{export}{A logical indicating whether to export the generated theme to a shareable .csv file.}
}
\description{
rs.ui modifies RStudio files such that they point to css files rs.ui generates.
Doing this allows the UI of RStudio to be customized. rs.ui backs up the un-modded
RStudio files such that the original RStudio setup can be restored.

rs.ui has two fundamental modes: \code{main_color} and \code{theme_def}.

If provided a \code{main_color}, rs.ui generates a custom theme based off this color
by calculating tints/shades and analogous colors. If rs.ui generates a theme you enjoy,
it can be exported with the export parameter so it can be shared!

If provided a valid \code{theme_def}, no generation takes place and rs.ui writes
css files according to the provided \code{theme_def}. This option was added to allow
finer control and sharing between rs.ui users.

At the moment, only MacOS is supported but it is possible to do the same on Windows and/or
Linux. With enough support, I can add this functionality.

I hope you enjoy this (I think) cool, but mostly useless, project! 💝
}
\examples{
# generating a theme given a color
rs.ui(main_color = "#504066")

# importing and using a theme_def specification
my_theme = read.csv("my_theme.csv")
rs.ui(theme_def = my_theme)

# restoring RStudio
rs.ui(restore = T)

# generating a theme and saving the csv (to modify or share)
rs.ui(main_color = "#205d89", export = T)
}
