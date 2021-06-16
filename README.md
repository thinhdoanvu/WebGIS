# Lập trình WebGis sử dụng R shiny
![kết quả của Project](README_img/result_all.png)
## 1. Khởi tạo và yêu cầu
Hệ điều hành: Ubuntu 20.10 hoặc Windows 10 x64
R studio: 1.3.1093
R base: 4.05 trở lên
### 1.1. Tạo mới shiny web
File - New File - Shiny Web App... - Có 2 lựa chọn
![Tạo mới Project](README_img/taomoi.png)
  + Single File (app.R)
  + Multiple Files(ui.R và server.R) 
Sự khác nhau của 2 lựa chọn này là: Single File sẽ thực hiện cả 2 chức năng Front End và Back End trong 1 tập tin lập trình. Còn Multiple Files sẽ tách riêng ra thành 2 tập tin khác nhau. Thông thường, file ui.R hay front End sẽ có chức năng hiển thị giao diện và load kết quả từ Back End. Tuy nhiên, khi lập trình đôi khi chúng ta cần thiết kế Front End ngay bên trong file Back End. Ví dụ, khi chúng ta login thành công thì mới hiển thị giao diện điều khiển hay đôi khi chúng ta thiết kế kiểu Dashboard như trong ví dụ này.
### 1.2. Load thư viện
Mở file ui.R và thêm các dòng này lên đầu tập tin:
library(shiny)
library(dplyr)
library(shinydashboard)
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
Các thư viện này được sử dụng cho dự án WebGIS trong ví dụ. Các bạn có thể đọc hiểu thêm trong các giải thích của R documents. Chú ý, khi cài đặt các thư viện này:
+ Nếu sử dụng R studio hệ điều hành Windows, thì khi load tập tin ui.R có yêu cầu các thư viện thì hệ thống sẽ tự động cài đặt (Không gặp lỗi)
+ Nếu sử dụng R stuio trong hệ điều hành Linux, thì khi load tập tin ui.R có các thư viện như trên, mặc nhiên hệ thống cũng sẽ tự cài đặt. Tuy nhiên, các máy khác nhau thì các thư viện cần thiết cũng khác nhau. Do đó, máy thì đủ và máy thì thiếu nên tốt nhất các bạn sẽ cài đặt thông qua giao diện Terminal:
##### R
##### > install.packages(c("shiny","dplyr","shinydashboard","ggplot2"))
Hoặc lần lượt từng Packages. Khi gặp lỗi ở đâu, hệ thống sẽ báo thiếu thư viện tương ứng và có gợi ý:
##### debian: lib-devxxx /redhat: lib-xxx
## 1.2. Tạo hiệu ứng bánh xe xoay vòng khi tải trang
###### options(spinner.color="#006272")
## 1.3. Thiết kế giao diện Dashboard
![Giao diện UIPage](README_img/uipage.png)
ui <- dashboardPage(
    dashboardHeader(title = "Genetics Conservation"), #Tiêu đề của Dashboard
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
