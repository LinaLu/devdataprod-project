library(shiny)
#options(shiny.trace=TRUE)


costConsumption <- function(age, no.cig.per.day, cost.pack, ex.lifetime, loss.of.life){
  cost.per.pack <- (no.cig.per.day / 20) * cost.pack
  total.cost <-  cost.per.pack * 365 * (ex.lifetime - age - loss.of.life) 
  sprintf("%.2f", total.cost)
}

lossLife <- function(age, no.cig, lifetime){
  total.minutes.lost <- (lifetime - age) * 365 * no.cig * 11
  total.loss.of.life <- total.minutes.lost / 60 / 24 / 365    
  sprintf("%.0f", round(total.loss.of.life))
}

num.people.dead.per.second = 6000000 / (365 * 24 * 3600);
num.people.dead.total <- 0

shinyServer(
  function(input, output, session) {
    
    age <- reactive({ 
      validate(need(input$age <= input$lifetime, "Age cannot be greater than life expectancy."))  
      input$age
    })

    output$loss.lifeexpectancy <- renderText({
      paste("Your life expectancy will be shorten with  ", lossLife(age(),input$no.cig, input$lifetime), " year")
    })
    
    output$cost.consumption <- renderText({
      loss.of.life <- as.numeric(lossLife(age(), input$no.cig, input$lifetime))
      cost.of.smoking <- costConsumption(age(),input$no.cig, input$cost.pack, input$lifetime, loss.of.life)
      paste("Your cost of consumption of tobacco is estimated to  ", cost.of.smoking, " $")
    })
    
    output$tobaccoDeadCount <- renderText({
      invalidateLater(1000, session)
      num.people.dead.total <<- num.people.dead.total + num.people.dead.per.second;
      paste("<h4>During this session <span style = 'color:red'>", 
            sprintf("%.0f", round(num.people.dead.total)),
            "</span> peoples have died in direct tobacco releated causes</h4>")
    })
    
  })



