library(shiny)
library(magick)

ui <- fluidPage(
   
   # Application title
   titlePanel("Busted Magick Density"),
   
   # Sidebar with a slider input for density
   sidebarLayout(
      sidebarPanel(
         sliderInput("density",
                     "Density:",
                     min = 150,
                     max = 2000,
                     value = 1200)
      ),
      
      # Show image as png
      mainPanel(
         imageOutput("ximage")
      )
   )
)

# Define server logic
server <- function(input, output) {
   
   output$ximage <- renderImage({
     filename <- normalizePath(file.path(paste0(getwd(),
                                                 "/pdf/DAGimageDoc.pdf")))
     image <-  image_convert(image_read(path=filename, 
                                        density = paste0(input$density,"x",input$density)),
                             "png")
     tmpfile <- image %>%
                 image_write(path=paste0(getwd(),"/image.png"),
                             format = 'png')
     
     list(src = tmpfile)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

