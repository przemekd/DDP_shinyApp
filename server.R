library(shiny)
library(ggplot2)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #
  output$BMIPlot <- renderPlot({
    wt = seq(30,220, length.out=1000)
    ht1 = sqrt(wt/18.5)*100
    ht2 = sqrt(wt/24.9)*100
    ht3 = sqrt(wt/30.0)*100
    htmin= rep(0,1000)
    htmax= rep(220,1000)
    
    ww <- data.frame(x = c(wt,wt,wt,wt),
                     ymin = c(ht1,ht2,ht3,htmin),
                     ymax = c(htmax,ht1,ht2,ht3),
                     grp = rep(c('Underweight','Normal', 'Overweight', 'Obesity'),each = 1000))
    print(
      ggplot(data = ww,aes(x = x,ymin = ymin, ymax = ymax,fill = grp)) + 
        geom_ribbon(alpha = 1) +
        scale_fill_manual(name = "BMI Category"
                          ,values = c('Underweight' = 'lightblue',
                                      'Normal' = 'green', 
                                      'Overweight' = 'yellow', 
                                      'Obesity' = 'red')
                          ,breaks = c('Underweight','Normal','Overweight','Obesity')
        )+
        coord_cartesian(xlim = c(40, 210), ylim = c(120, 220))+
        scale_x_continuous("Weight [kg]", breaks = seq(10, 220, 20)) +
        scale_y_continuous("Height [cm]", breaks = seq(120, 220, 20))+
        theme_bw() +
        geom_vline(xintercept=seq(50, 200, by=10), colour="white", linetype="dotted") +
        geom_hline(yintercept=seq(130, 210, by=10), colour="white", linetype="dotted") +
        annotate("point", x=as.numeric(input$wt), y=as.numeric(input$ht), size=4)+
        annotate("text", x=as.numeric(input$wt)+5, y=as.numeric(input$ht)+5, label="You")
    )
    
    #Obese
    #BMI >30
    #
    #Overweight 
    #BMI 25 - 30
    #
    #Normal range
    #BMI 18.5 - 25
    #
    #Underweight 
    #BMI < 18.5
  })
  
  output$BMR <- renderText({
    if(input$gender=='male') {
      10 * as.numeric({input$wt}) + 6.25 * as.numeric({input$ht}) - 5 * as.numeric({input$age}) + 5 
    } else {
      10 * as.numeric({input$wt}) + 6.25 * as.numeric({input$ht}) - 5 * as.numeric({input$age}) - 161         
    }
      
    })
})