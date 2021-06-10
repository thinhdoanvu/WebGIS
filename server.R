mydata = read.csv("www/mydata.csv",header = TRUE, sep = ";",encoding = 'UTF-8') 
sample_loc <- readOGR(dsn ="www/shapefiles/HoaQuangNam_Bac", layer = "HoaQuangNam_Bac")

greenLeafIcon <- makeIcon(
    iconUrl = "http://leafletjs.com/examples/custom-icons/leaf-green.png",
    iconWidth = 38, iconHeight = 95,
    iconAnchorX = 22, iconAnchorY = 94,
    shadowUrl = "http://leafletjs.com/examples/custom-icons/leaf-shadow.png",
    shadowWidth = 50, shadowHeight = 64,
    shadowAnchorX = 4, shadowAnchorY = 62
)

shinyServer(function(input, output) {
    
    output$SHPplot <-  renderLeaflet({
        
        initial_lat = 13.111667
        initial_lng = 109.225278
        initial_zoom = 10
            
        #Add map
        leaflet(data = mydata) %>%
        addProviderTiles ("Esri.WorldImagery", options = providerTileOptions(minZoom = 6, maxZoom = 17)) %>% 
        setView(lat = initial_lat, lng = initial_lng, zoom = initial_zoom) %>%
        
        #Add circle
        #addCircles(lng = 109.204444, lat = 13.071389, weight = 3,radius = 14*100, popup = "Hòa Quang Nam") %>%
        #addCircles(lng = 109.225278, lat = 13.111667, weight = 3,radius = 5*100, popup = "Hòa Quang Bắc") %>%
            
        #Add shape
        addPolygons(data = sample_loc, fill = TRUE, weight = 2, opacity = 0.7, color = "#f55c47", dashArray = "3", smoothFactor = 1, label = ~NAME_3) %>%
            
        #Add marker, popup cac diem thu mau
        addMarkers(~long, 
                   ~lat, 
                   icon = greenLeafIcon,
                   popup = paste("<strong>",mydata$specifies, '</strong>',"<br>",
                                    "<img src = ",mydata$Pictures, " width = 300 >", #Neu trong file data da co dau ' trong duong dan hinh anh & Chu y ca dau cach
                                    #"<img src = '",mydata$Pictures, "' width = 100 >",  # Neu trong file data khong co dau ' cua duong dan hinh anh & Chu y ca dau cach
                                    "<br>",
                                    mydata$Description,
                                 "<br>",
                                 "<i><a href='http://www.samurainoodle.com'>Details</a></i>"
                                 ), 
                   #Cluster options
                   clusterOptions = markerClusterOptions(),
                   clusterId = "quakesCluster"
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
                img(src='images/sp1.jpg', width = "100%",height ="100%"), #float = "left", margin =  "left", border = "2", pading = "20")
                h4("Scientific classification"),
                "Kingdom: Plantae",
                p(tags$i("Clade"),": Tracheophytes"),
                p(tags$i("Clade"),": Angiosperms"),
                p(tags$i("Clade"),": Eudicots"),
                p("Order: Ranunculales"),
                p("Family: Menispermaceae"),
                p("Genus: Stephania"),
                p("Lour.")
            ),
            mainPanel(
                p(
                    tags$b("Stephania"),
                    "is a genus of flowering plants in the family Menispermaceae, native to eastern and southern Asia and Australia. They are herbaceous perennial vines growing to around four metres tall, with a large, woody caudex. The leaves are arranged spirally on the stem, and are peltate, with the leaf petiole attached near the centre of the leaf. The name Stephania comes from the Greek, a crown. This refers to the anthers being arranged in a crown like manner.",
                    br(),
                    "One species, S. tetrandra, is among the 50 fundamental herbs used in traditional Chinese medicine, where it is called han fang ji. Other plants named fang ji are sometimes substituted for it. Other varieties substituted include Cocculus thunbergii, C. trulobus, Aristolochia fanchi, Stephania tetrandria, and Sinomenium acutun. Notable among these is guang fang ji, Aristolochia fanchi. Because of its toxicity, it is used in TCM only with great caution.",  
                    h4("Selected species"),
                    "There are about 45 species in the genus Stephania, native to the Far East and Australasia.", cite = "[2]", "Species include:",cite ="[3]",
                    
                ),
                fluidRow(
                    column(width=6,
                           #tags$ol(
                           tags$li(tags$i("Stephania aculeata")," FM Bailey"),
                           tags$li(tags$i("Stephania bancroftii")," FM Bailey"),
                           tags$li(tags$i("Stephania brevipes")," Craib"),
                           tags$li(tags$i("Stephania capitata")," (Blume) Spreng."),
                           tags$li(tags$i("Stephania cephalantha")," Hayata"),
                           tags$li(tags$i("Stephamia corymbosa")," (Blume) Walp."),
                           tags$li(tags$i("Stephania crebra")," Forman"),
                           tags$li(tags$i("Stephania elegans")," Hook.f. & Thomson"),
                           tags$li(tags$i("Stephania glabra")," (Roxb.) Miers"),
                           tags$li(tags$i("Stephania glandulifera")," Miers"),
                           tags$li(tags$i("Stephania gracilenta")," Miers"),
                           tags$li(tags$i("Stephania hernandiifolia")," (Willd.) Walp."),
                           tags$li(tags$i("Stephania hispidula")," (Yamamoto) Yamamoto"),
                           tags$li(tags$i("Stephania japonica")," (Thunb.) Miers"),
                           tags$li(tags$i("Stephania kaweesakii")," Jenjitt. & Ruchis")
                           #),
                    ),
                    column(width=6,
                           #tag$ol(
                           tags$li(tags$i("Stephania longa")," Lour. - type species"),
                           tags$li(tags$i("Stephania merrillii")," Diels"),
                           tags$li(tags$i("Stephania oblata")," Craib"),
                           tags$li(tags$i("Stephania papillosa")," Craib"),
                           tags$li(tags$i("Stephania pierrei")," Diels"),
                           tags$li(tags$i("Stephania reticulata")," Forman"),
                           tags$li(tags$i("Stephania rotunda")," Lour."),
                           tags$li(tags$i("Stephania sinica")," Diels"),
                           tags$li(tags$i("Stephania suberosa")," L.L.Forman"),
                           tags$li(tags$i("Stephania subpeltata")," H.S.Lo"),
                           tags$li(tags$i("Stephania tetrandra")," S. Moore"),
                           tags$li(tags$i("Stephania tomentella")," Forman"),
                           tags$li(tags$i("Stephania tuberosa")," Forman"),
                           tags$li(tags$i("Stephania venosa")," (Blume) Spreng.")
                    )
                    #)
                ),#End fluidRow
                fluidRow(
                    h4("Fossil species"),
                    "Stephania palaeosudamericana Herrera et al.",
                    h4("Synonyms"),
                    "Stephania erecta Craib (syn. Stephania pierrei Diels)",
                    h4("Toxicity"),
                    "There is evidence that a few species of Stephania are toxic. However, the most commonly available species in the United States, Stephania tetrandra, has not been shown to be toxic. Any confusion regarding the possible toxicity of Stephania tetrandra was entirely due to an inadvertent shipment of Aristolochia fangchi sent in its stead to a Belgian clinic in 1993. The errant batch of Aristolochia was later confirmed via phytochemical analysis.",
                )
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
                   div(style="display: inline-block;",img(src="images/SP1.jpg", height=300, width=300)),
                   div(style="display: inline-block;",img(src="images/SP2.jpg", height=300, width=300)),
                   div(style="display: inline-block;",img(src="images/SP3.jpg", height=300, width=300)),
                   div(style="display: inline-block;",img(src="images/SP4.jpg", height=300, width=300)))
            )
    })#End of image Render UI
    
})#End of Section Input Output

