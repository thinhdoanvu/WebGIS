library(shiny)
library(dplyr)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(stringr)
library(DT)
library(shinyBS)
library(shinyjs)
library(shinycssloaders)
library(leaflet)
library(htmltools)
library(sf)
library(leafpop)
library(rjson)
library(rgdal)

options(spinner.color="#006272")

ui <- dashboardPage(
    dashboardHeader(title = "NTU WebGIS"),
    
    ## Sidebar content
    dashboardSidebar(
        sidebarMenu(
            menuItem("Locations", tabName = "dashboard", icon = icon("pagelines")),
            menuItem("Widgets", tabName = "widgets", icon = icon("th"),
                     menuSubItem("Infomation", icon = icon("info-circle"),tabName ="infomation"),
                     menuSubItem("Sequences", icon = HTML('<i class="fas fa-dna"></i>'),tabName ="genetics"),
                     menuSubItem("Images", icon = icon("image"),tabName ="image")
                     )
        )
    ),
    
    #Body
    dashboardBody(
        tabItems(
            # MAP tab content
            tabItem(tabName = "dashboard",
                    leafletOutput("SHPplot", height = 570)),
            
            # Second tab content
            tabItem(tabName = "widgets",
                    h2("Widgets tab content")),
            
            #Subtab items
            tabItem(tabName = "infomation", 
                    uiOutput("infomation")),
            
             tabItem(tabName = "genetics", 
                     uiOutput("genetics")),
            
             tabItem(tabName = "image",
                     #tableOutput('files'),
                     uiOutput("image"))
        )
    )#End Body
    
    )#End UI Dashboard