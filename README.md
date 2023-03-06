# rs.ui
rs.ui modifies RStudio files such that they point to css files rs.ui generates. Doing this allows the UI of RStudio to be customized. 
rs.ui backs up the un-modded RStudio files such that the original RStudio setup can be restored.

Here's an example of a normal-dark mode RStudio theme, wherein the borders are always a blue-ish color:
![Screenshot 2023-03-06 at 12 54 45 PM](https://user-images.githubusercontent.com/83082268/223216619-18d8b7fc-b46c-4be5-818c-744956c2ddff.png)
With rs.ui, you can have something like this in seconds:
![Screenshot 2023-03-06 at 12 57 19 PM](https://user-images.githubusercontent.com/83082268/223217042-a50d79cf-906e-4b3a-8af2-e539fbe73836.png)

## Usage
rs.ui can be installed with the following command:
```
devtools::install_github("grcatlin/rs.ui")
```

The basic flow of rs.ui is to call `rs.ui()`, then reboot or reload RStudio.
```
library(rs.ui)
rs.ui(main_color = "#205d89")
```
**Notice only the editor is modified at this point, you need to restart RStudio or reload it from here.**
![Screenshot 2023-03-06 at 12 59 13 PM](https://user-images.githubusercontent.com/83082268/223217464-a6cb0847-249e-4925-9bf4-c88c3973a983.png)
**Upon restart**
![Screenshot 2023-03-06 at 1 01 25 PM](https://user-images.githubusercontent.com/83082268/223218000-83c95326-14ff-4817-900b-6b82154d3ab2.png)

From here, you will only need to use the rs.ui library again if you want to change the theme or restore RStudio!

## Exact Theme or Theme Generation? Both!

### main_color
If provided a main_color, rs.ui generates a custom theme based off this color
by calculating tints/shades and analogous colors. If rs.ui generates a theme you enjoy,
it can be exported with the export parameter so it can be shared!

### theme_def
If provided a valid theme_def, no generation takes place and rs.ui writes
css files according to the provided theme_def. This option was added to allow
finer control and sharing between rs.ui users.

## Examples

`rs.ui(main_color = "#504066")`
![Screenshot 2023-03-06 at 1 05 08 PM](https://user-images.githubusercontent.com/83082268/223218683-31b88711-461b-4d5b-bd85-784b0c06e7b2.png)

`rs.ui(main_color = "#5f8065")`
![Screenshot 2023-03-06 at 1 05 38 PM](https://user-images.githubusercontent.com/83082268/223218820-d9a45ec8-4636-43ee-970d-73e890d67557.png)

`rs.ui(main_color = "#545255")`
![Screenshot 2023-03-06 at 1 06 30 PM](https://user-images.githubusercontent.com/83082268/223218962-84073159-f62d-4000-9b9c-d55ef76fd09d.png)

`rs.ui(theme_def = theme_def_ex)`
![Screenshot 2023-03-06 at 1 07 30 PM](https://user-images.githubusercontent.com/83082268/223219151-3b790166-5bfe-4aeb-8840-0d6792389b9d.png)

```
my_theme = read.csv("theme.csv")
rs.ui(theme_def = my_theme)
```
![Screenshot 2023-03-06 at 1 14 42 PM](https://user-images.githubusercontent.com/83082268/223220570-5ed68d34-56d6-4e4f-8579-af428701d850.png)

## Caveats
At the moment, only MacOS is supported but it is possible to do the same on Windows and/or Linux.

## Thanks for Stopping By!
Major shout-out goes to [rileytwo's darkstudio](https://github.com/rileytwo/darkstudio) which served as the basis for this project. 
I hope you enjoy this (I think) cool, but mostly useless, package! 💝
