require(plyr)
require(plotrix)
require(rCharts)
require(rgdal)
require(sp)
require(XLConnect)

# 1. Read in the data and preprocess ---------------------------------------
patch.data <- readWorksheetFromFile("suoajot/Päätösyksikkö_Zonationtaulukko.xlsx",
                                    "Taul1")

patch.data$SZonSuojelu <- factor(patch.data$SZonSuojelu, levels=c(1, 2, 3),
                                 labels=c("Täysin suojelematon", 
                                          "Osin suojeltu", "Kokonaan suojeltu"))

# Create a new variable for sorting purposes
patch.data$rank_sum <- patch.data$SDSumm45 / (1.01 - patch.data$MeanRank45)

# Get only patches that have a notable SDSumm45
plot.data <- subset(patch.data, SDSumm45 > 0)
plot.data$SDSumm45.logged  <- log(plot.data$SDSumm45) + 10
plot.data$SDSumm45.multi <- plot.data$SDSumm45 * 1000

# Let's take just the 1000 best as ranked by rank_sum
plot.data <- arrange(plot.data, desc(rank_sum))
plot.data <- plot.data[1:1000,]

# Let's reproject from YKJ to ETRS-TM35FIN. This is needed in order to create
# the "open" links to karttapaikka.
sp.ykj <- SpatialPointsDataFrame(plot.data[, c("YKJ_X", "YKJ_Y")], plot.data,
                                 proj4string = CRS("+init=epsg:2393"))
sp.etrs <- spTransform(sp.ykj, CRS("+init=epsg:3067"))
plot.data$ETRS_X <- coordinates(sp.etrs)[,1]
plot.data$ETRS_Y <- coordinates(sp.etrs)[,2]



# 2. Data preparation -----------------------------------------------------

# Construct a data frame that holds all the necessary data for plotting
plot.table <- data.frame(
          x = plot.data$SDSumm45.logged,
          y = plot.data$MeanRank45,
          z = plot.data$AREA_PIX,
          name = plot.data$NIMI,
          group = plot.data$SZonSuojelu,
          p10 = plot.data$P10_45,
          p1 = plot.data$P1_45,
          p01 = plot.data$P01_45,
          p001 = plot.data$P001_45,
          kp_url = paste0("http://kansalaisen.karttapaikka.fi/kartanhaku/koordinaattihaku.html?y=",
                           plot.data$ETRS_Y,
                          "&x=",
                          plot.data$ETRS_X,
                          "&srsName=EPSG%3A3067&scale=16000&tool=siirra&styles=normal&lang=fi&mode=orto")
)

# Split the list into categories
plot.series <- lapply(split(plot.table, plot.data$SZonSuojelu), function(x) {
  res <- lapply(split(x, rownames(x)), as.list)
  names(res) <- NULL
  return(res)
})

# 3. Visualisation --------------------------------------------------------

# Create the chart object
a <- rCharts::Highcharts$new()

# Create the separate data series based on the group variable (SZonSuojelu)
invisible(sapply(plot.series, function(x) {
  a$series(data = x, type = "bubble", name = x[[1]]$group)
}))

# Define the behaviour when mouse pointer is hovered or clicked
a$plotOptions(
  bubble = list(
    cursor = "pointer",
    point = list(
      events = list(
        click = "#! function() { window.open(this.options.kp_url); } !#")),
    marker = list(
      symbol = "circle",
      radius = 10
    )
  )
)

# Define a custom tooltip
tooltip <- paste0("#! function() {return ",
                  "'<strong>' + this.point.name + '</strong><br />'",
                  " + 'Size: ' + this.point.z + ' ha<br />'",
                  " + ' <br />'",
                  " + 'X % piirteiden esiintymästä yksikössä' + '<br />'",
                  " + '> 10%: ' + this.point.p10 + '<br />'",
                  " + '> 1%: ' + this.point.p1 + '<br />'",
                  " + '> 0,1%: ' + this.point.p01 + '<br />'",
                  " + '> 0,01%: ' + this.point.p001",
                  "; } !#")

a$tooltip(useHTML = T, formatter = tooltip)

a$colors( 
  'rgba(223, 83, 83, .7)', 
  'rgba(119, 152, 191, .7)',
  'rgba(69, 173, 72, .7)'
)

a$legend(
  align = 'right',
  verticalAlign = 'middle',
  layout = 'vertical',
  title = list(text = "Suojeltu")
)
a$xAxis(title = list(text = "log(SDSumm)"))
a$yAxis(title = list(text = "MeanRank"))

a$params$width <- 1000
a$params$height <- 700
a$chart(zoomType = "xy")

a$title(text = "MeanRank vs SDSUmm")
a$subtitle(text = "Suojellut ja suojelemattomat yksiköt")
# Plot it!
a

#htmlFile <- tempfile(fileext=".html")


#a$publish('Variantti45', host = 'rpubs')
