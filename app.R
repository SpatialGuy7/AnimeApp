# Load Libraries
library(shiny)
library(sf)
library(leaflet)
library(dplyr)

# Read in the geojson from Github
Japan <- read_sf("https://raw.githubusercontent.com/SpatialGuy7/GeoJSON-Data/main/merged_data.geojson")

# Define UI for application
ui <- fluidPage(
  # Application title
  titlePanel("Favourite Anime per Prefecture"),
  leafletOutput("JapMap", height = "700px", width = "100%"),
  tags$style(type="text/css", "#map_legend {position:absolute; top:10px; left:100px; background:blue; color:white; padding:10px; border: 1px solid black; width: 200px;}")
)

# Define server logic
server <- function(input, output) {
  output$JapMap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(provider = "Esri.WorldTerrain") %>%
      addPolygons(data = Japan, color = "red", fillColor = "green", fillOpacity = 0.5, weight = 1,
                  highlightOptions = highlightOptions(weight = 2, color = "pink", fillColor = "blue", bringToFront = TRUE),
                  label = ~paste(name_csv),
                  popup = ~paste0("<strong>Anime:</strong> ", anime, "<br>",
                                  linkhtml)
      ) %>%
      addControl(html = "<div id='map_legend'>Click on a prefecture to view which anime was voted as its favourite ≽^•⩊•^≼</div>")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
