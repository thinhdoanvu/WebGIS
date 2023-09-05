mydata = read.csv("www/mydata.csv",header = TRUE, sep = ";",encoding = 'UTF-8') 
#sample_loc <- readOGR(dsn ="www/shapefiles/HoaQuangNam_Bac", layer = "HoaQuangNam_Bac")

greenLeafIcon <- makeIcon(
    iconUrl = "www/icon/location-dot-solid.png",
    iconWidth = 25, iconHeight = 45,
    iconAnchorX = 22, iconAnchorY = 94,
    shadowUrl = NULL,
    shadowWidth = 50, shadowHeight = 64,
    shadowAnchorX = 4, shadowAnchorY = 62
)

shinyServer(function(input, output) {
    
    output$SHPplot <-  renderLeaflet({
        
        initial_lat = 12.267738532937882
        initial_lng = 109.20153058595555
        initial_zoom = 17
            
        #Add map
        leaflet(data = mydata) %>%
        addProviderTiles ("Esri.WorldImagery", options = providerTileOptions(minZoom = 10, maxZoom = 17)) %>% 
        setView(lat = initial_lat, lng = initial_lng, zoom = initial_zoom) %>%
        
        #Add circle
        #addCircles(lng = 109.204444, lat = 13.071389, weight = 3,radius = 14*100, popup = "Hòa Quang Nam") %>%
        #addCircles(lng = 109.225278, lat = 13.111667, weight = 3,radius = 5*100, popup = "Hòa Quang Bắc") %>%
            
        #Add shape
        #addPolygons(data = sample_loc, fill = TRUE, weight = 2, opacity = 0.7, color = "#f55c47", dashArray = "3", smoothFactor = 1, label = ~NAME_3) %>%
            
        #Add marker, popup cac diem thu mau
        
        addMarkers(~long, 
                   ~lat, 
                   icon = greenLeafIcon,
                   popup = paste("<strong>",mydata$specifies, '</strong>',"<br>",
                                    "<img src = ",mydata$Pictures, " width = 300 >", #Neu trong file data da co dau ' trong duong dan hinh anh & Chu y ca dau cach
                                    #"<img src = '",mydata$Pictures, "' width = 100 >",  # Neu trong file data khong co dau ' cua duong dan hinh anh & Chu y ca dau cach
                                    "<br>",
                                    mydata$Description
                                 #"<br>",
                                 #"<i><a href='http://www.samurainoodle.com'>Details</a></i>"
                                 ), 
                   #Cluster options
                   #clusterOptions = markerClusterOptions(),
                   #clusterId = "quakesCluster"
        ) %>%
            
        #Distance and Square
        addMeasure(primaryLengthUnit="kilometers", secondaryLengthUnit="kilometers") %>%
        
        #Add Button
            addEasyButton(
            
                #Zoom in / Out
                easyButton(icon="fa-globe", 
                    title="Zoom to fit map",
                    onClick=JS("function(btn, map){ map.setZoom(6);}"))) %>%
                
                #unfreeze / freeze
                addEasyButtonBar(easyButton(
                    states = list(
                        easyButtonState(stateName="frozen-markers",
                                        icon="ion-toggle-filled",
                                        title="UnFreeze Clusters",
                                        onClick = JS("function(btn, map) {
                                        var clusterManager =
                                        map.layerManager.getLayer('cluster', 'quakesCluster');
                                        clusterManager.unfreeze();
                                                     btn.state('unfrozen-markers');}")),
                
                #freeze
                        easyButtonState(stateName="unfrozen-markers",
                                        icon="ion-toggle",
                                        title="Freeze Clusters",
                                        onClick = JS("function(btn, map) {
                                                var clusterManager =
                                                map.layerManager.getLayer('cluster', 'quakesCluster');
                                                clusterManager.freezeAtZoom();
                                                             btn.state('frozen-markers');}"))        
                    ))) #End of Button
            
            
                
            
    })#End of leaflet
    
    #---------------------------------------------------------------------------
    
    #Lien quan den menu
    output$infomation <- renderUI({
        fluidPage(
            sidebarPanel(
                img(src='images/ntu05.jpg', width = "100%",height ="100%"), #float = "left", margin =  "left", border = "2", pading = "20")
                h4("Scientific classification"),
                p("Kingdom: Fungi"),
                p(tags$i("Division"),": Basidiomycota"),
                p(tags$i("Class"),": Agaricomycetes"),
                p(tags$i("Order"),": Polyporales"),
                p("Family: Ganodermataceae"),
                p("Genus: Ganoderma"),
                p("P.Karst. (1881)")
            ),
            mainPanel(
                p(
                    tags$b("The Ganodermataceae"),
                    " is a family of fungi that belongs to the order Polyporales within the phylum Basidiomycota. This family is notable for including some of the most well-known and medically important mushroom species, particularly those within the genus Ganoderma. Here are some key points about the Ganodermataceae family:",
                    br(),
                    tags$b("Genera: "),
                    "The family Ganodermataceae contains several genera, with Ganoderma being the most prominent and widely recognized. Other genera within this family include Elfvingia, Fomes, and Tomophagus, among others.",  
                    br(),
                    tags$b("Morphology: "),
                    "Fungi in the Ganodermataceae family are typically characterized by their tough, woody fruiting bodies, known as polypores. These polypores are often shelf-like or bracket-shaped and can be quite large. They usually have a hard and woody texture, making them distinct from many other mushroom families.",
                    br(),
                    tags$b("Habitat: "),
                    "Members of this family are primarily saprophytic, meaning they obtain their nutrients from decomposing organic matter. They are commonly found growing on dead or dying trees, particularly hardwoods, where they play a vital ecological role in breaking down wood and recycling nutrients.",
                    br(),
                    tags$b("Medicinal and Nutritional Importance: "),
                    "The genus Ganoderma, in particular, has a long history of use in traditional medicine, particularly in Asian cultures. Certain Ganoderma species, such as Ganoderma lucidum (known as Reishi or Lingzhi), have been studied for their potential health benefits. They are believed to possess antioxidant and immunomodulatory properties and have been used in various traditional remedies. Additionally, they are a source of bioactive compounds.",
                    br(),
                    tags$b("Cultural Significance: "),
                    "Ganoderma species have cultural significance in some parts of the world. They have been revered in traditional Chinese and Japanese medicine for centuries and are often associated with longevity and health-promoting properties.",
                    br(),
                    tags$b("Taxonomy: "),
                    "The taxonomy of fungi within the Ganodermataceae family has undergone revisions as molecular techniques have advanced. DNA analysis has helped clarify the relationships between different species within the family.",
                    br(),
                    tags$b("TaxonomyEconomic Importance: "),
                    "Beyond their medicinal and cultural significance, some species within the Ganodermataceae family can cause white rot in trees, leading to economic concerns in forestry and agriculture.",
                    br(),
                    tags$b("Conservation: "),
                    "Some species within this family may be susceptible to habitat loss and degradation, making their conservation important, particularly if they have unique ecological roles or medicinal potential.",
                    
                ),
               
                
            ),
        )  
            
        
    })#End of Infomation
    
    
    output$genetics <- renderUI({
        
        #Thiet ke giao dien trong Backend
        fluidPage(width =12,
                    h4("Sequence data"),
                     # hr(),
                     # #Hien thi thanh cuon
                     # div(style = 'overflow-y: scroll; max-height: 500px; overflow-x: scroll; max-width: 100%',uiOutput("dna"))
                  column(width=3,
                         tags$a(href="/dna/BL3-F_E09.ab1", "BL3-F_E09.ab1"),br(),
                         tags$a(href="/dna/BL3-R_F09.ab1", "BL3-R_F09.ab1"),br(),
                         tags$a(href="/dna/BL4-F_G09.ab1", "BL4-F_G09.ab1"),br(),
                         tags$a(href="/dna/BL4-R_H09.ab1", "BL4-R_H09.ab1"),br(),
                         tags$a(href="/dna/BL5-F_G07.ab1", "BL5-F_G07.ab1"),br(),
                         tags$a(href="/dna/BL5-R_H07.ab1", "BL5-R_H07.ab1"),br(),
                         tags$a(href="/dna/E1-F_A10.ab1", "E1-F_A10.ab1"),br(),
                  ),
                  column(width=3,
                         tags$a(href="/dna/E1-R_B10.ab1", "E1-R_B10.ab1"),br(),
                         tags$a(href="/dna/L25-F_F03.ab1", "L25-F_F03.ab1"),br(),
                         tags$a(href="/dna/L25-R_D09.ab1", "L25-R_D09.ab1"),br(),
                         tags$a(href="/dna/L28-F_H03.ab1", "L28-F_H03.ab1"),br(),
                         tags$a(href="/dna/L28-R_B09.ab1", "L28-R_B09.ab1"),br(),
                         tags$a(href="/dna/PY1-F_E10.ab1", "PY1-F_E10.ab1"),br(),
                         tags$a(href="/dna/PY1-R_F10.ab1", "PY1-R_F10.ab1"),br(),
                  ),
                  
                  column(width=3,
                         tags$a(href="/dna/R1-F_C07.ab1", "R1-F_C07.ab1"),br(),
                         tags$a(href="/dna/R1-R_D07.ab1", "R1-R_D07.ab1"),br(),
                         tags$a(href="/dna/R9-F_E07.ab1", "R9-F_E07.ab1"),br(),
                         tags$a(href="/dna/R9-R_F07.ab1", "R9-R_F07.ab1"),br(),
                         tags$a(href="/dna/S2-F_C10.ab1", "S2-F_C10.ab1"),br(),
                         tags$a(href="/dna/S2-R_D10.ab1", "S2-R_D10.ab1"),br(),
                         tags$a(href="/dna/S2a-F_D03.ab1", "S2a-F_D03.ab1"),br(),
                  ),
                  column(width=3,
                         tags$a(href="/dna/S2a-R_H08.ab1", "S2a-R_H08.ab1"),br(),
                         tags$a(href="/dna/S3a-F_E03.ab1", "S3a-F_E03.ab1"),br(),
                         tags$a(href="/dna/S3a-R_F08.ab1", "S3a-R_F08.ab1"),br(),
                         tags$a(href="/dna/TT52-F_A08.ab1", "TT52-F_A08.ab1"),br(),
                         tags$a(href="/dna/TT52-R_B08.ab1", "TT52-R_B08.ab1"),br(),
                         tags$a(href="/dna/TT54-F_C08.ab1", "TT54-F_C08.ab1"),br(),
                         tags$a(href="/dna/TT54-R_D08.ab1", "TT54-R_D08.ab1"),br(),
                  ),
                  
                 )#End fluid page
        
    })
    
    #Table list image name 
    output$files <- renderTable(input$files)
    
    files <- reactive({
        files <- input$files
        files$datapath <- gsub("\\\\", "/", files$datapath)
        files
    })
    
    #Hien thi hinh anh
    output$image <- renderUI({
        # #Thiet ke giao dien chon file
        # fileInput(inputId = 'files', 
        #           label = 'Select an Image',
        #           multiple = TRUE,
        #           accept=c('image/png', 'image/jpeg'))
        # 
        # #uiOutput("listimage")
        
        fluidRow(
            column(12, align="center",
                   div(style="display: inline-block;",img(src="images/ntu05.jpg", height=300, width=300)),
                   div(style="display: inline-block;",img(src="images/ntu06.jpg", height=300, width=300)),
                   div(style="display: inline-block;",img(src="images/ntu07.jpg", height=300, width=300)))
                   #div(style="display: inline-block;",img(src="images/SP4.jpg", height=300, width=300)))
            )
    })#End of image Render UI
    
})#End of Section Input Output

