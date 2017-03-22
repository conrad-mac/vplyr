# vplyr - dplyr with voice recognition

This app uses R, [shiny](https://shiny.rstudio.com/) and [annyang](https://www.talater.com/annyang/) to analyse and visualise data using speech. I first got the idea to pair shiny with annyang after seeing [this app](https://yihui.shinyapps.io/voice/) by Yihui Xie (see [here](https://github.com/yihui/shiny-apps/tree/master/voice) for code).

### v0.2
Some updates. Still a work in progress. Can currently use filter, select and plot commands. The select command can only take one variable at the moment. Bootstrap theme changed

### v0.1
- First upload - WIP

### To do
- Have the select command take multiple variables. I think this can be done using the * in annyang and saying "comma" after each word (and then parsing the result in R)
- Add more commands (e.g. mutate, summarise, etc.)

