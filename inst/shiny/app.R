# Define UI for application
ui <- fluidPage(

  # Application title
  titlePanel(h4("St-Petersburg paradox games")),

  sidebarLayout(
    sidebarPanel(
      numericInput("n_games", "Number of games:", 10, 1, 1e4),
      numericInput("fee", "Fee for playing one game:", 10, 1, 1e7),
      numericInput("seed", "Simulation seed", 123, 1, 1e7),
      actionButton("play", "Let's play the games!", icon = icon("gamepad"))
    ),

    mainPanel(
      plotOutput("hist")
    )
  )
)

server <- function(input, output) {

  # play the games
  play <- eventReactive(input$play, {
    # St-Petersburg function that creates an object of class "sp_game"
    st_petersburg_game(n_games = input$n_games, fee = input$fee,
                       seed = input$seed)
  })

  # plot the output
  output$hist <- renderPlot({
    plot(play())
  }, height = 620)
}

shinyApp(ui = ui, server = server)
