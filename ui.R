# ui.R

library(shiny)

shinyUI(fluidPage(
  titlePanel("Your money and your life."),
  sidebarLayout(
    sidebarPanel(
      numericInput("age", label = h4("Smoking since the age of"), 20, min=0, max=200),
      sliderInput("no.cig", label = h4("Cigarettes per day"), min = 0, max = 100, value = 10),
      numericInput("cost.pack", label = h4("Cost per pack in USD"), 5.51, min=0, max=100),
      numericInput("lifetime",label = h4("Average life expectancy"), 70, min=0, max=200)),
     
    mainPanel(
      htmlOutput("tobaccoDeadCount"),
      br(),
      h4(textOutput("loss.lifeexpectancy")),
      h4(textOutput("cost.consumption"))
      )
    )
  ))