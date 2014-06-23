library(shiny)
library(ggplot2)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("BMI and BMR calculators"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    h3("Introduction"),
    p("Obesity is a medical condition that leads to reduced life expectancy and/or increased health problems. Check your BMI and your need for calories using these calculators."),
    h3("Inputs"),
    #p("Please input information"),
    
    selectInput("gender", "Choose gender:", choices = c("male", "female")),
    sliderInput("age", 
                "Your age:", 
                min = 1,
                max = 120, 
                value = 25),
    sliderInput("ht", 
                "Your height (in centimeters):", 
                min = 140,
                max = 210, 
                value = 175),
    sliderInput("wt",
                "Your weight (in kilograms):", 
                min = 40,
                max = 200, 
                value = 70)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("BMI", p('A graph of body mass index as a function of body mass and body height:'), plotOutput("BMIPlot")),
      tabPanel("BMR", 
               p('Basal metabolic rate (BMR), and the closely related resting metabolic rate (RMR), is the rate of energy expenditure by humans and other animals at rest. Rest is defined as existing in a neutrally temperate environment while in the post-absorptive state. The release, and using, of energy in this state is sufficient only for the functioning of the vital organs: the heart, lungs, nervous system, kidneys, liver, intestine, sex organs, muscles, brain and skin.'),
               p('Yout basal metabolic rate (kcal):'), 
               h2(textOutput("BMR")))
    )
  )
))