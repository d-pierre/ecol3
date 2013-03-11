library(shiny)

# Define UI 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Paramètres de la compétition interspécifique"),
  
  
  sidebarPanel(
  
      sliderInput("K1", "Valeur de K espèce 1",
                  min = 0, max=2000, value=680),
      sliderInput("K2", "Valeur de K espèce 2",
                  min = 0, max=2000, value=800),
      sliderInput("r1", "taux croissance espèce 1",step=0.1,
                  min = 0, max=5, value=0.3),
      sliderInput("r2", "taux croissance espèce 2",step=0.1,
                  min = 0, max=5, value=0.2),
      sliderInput("Alpha12", "effet espèce 1 sur espèce 2",step=0.1,
                  min = 0, max=3, value=1),
      sliderInput("Alpha21", "effet espèce 2 sur espèce 1",step=0.1,
                  min = 0, max=3, value=1),
      sliderInput("n01", "effectif départ espèce 1",step=5,
                  min = 1, max=1000, value=5),
      sliderInput("n02", "effectif départ espèce 2",step=5,
                  min = 1, max=1000, value=5),
      sliderInput("t", "Pas de temps",step=5,
                  min = 5, max=300, value=100)
    ),
  
  
  mainPanel(
    plotOutput("plot", width = "100%", height = "800px")
)))

