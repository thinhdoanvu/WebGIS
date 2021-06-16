# Lập trình WebGis sử dụng R shiny
<img src="https://github.com/thinhdoanvu/WebGIS/blob/main/README_img/result_all.png" width=70% height=70%>
## 1. Khởi tạo và yêu cầu
### 1.1. Tạo mới shiny web
File - New File - Shiny Web App... - Có 2 lựa chọn
<img src="https://github.com/thinhdoanvu/WebGIS/blob/main/README_img/taomoi.png" width=70% height=70%>
  + Single File (app.R)
<img src="https://github.com/thinhdoanvu/WebGIS/blob/main/README_img/singlefile.JPG" width=70% height=70%>
  + Multiple Files(ui.R và server.R) 
Sự khác nhau của 2 lựa chọn này là: Single File sẽ thực hiện cả 2 chức năng Front End và Back End trong 1 tập tin lập trình. Còn Multiple Files sẽ tách riêng ra thành 2 tập tin khác nhau. Thông thường, file ui.R hay front End sẽ có chức năng hiển thị giao diện và load kết quả từ Back End. Tuy nhiên, khi lập trình đôi khi chúng ta cần thiết kế Front End ngay bên trong file Back End. Ví dụ, khi chúng ta login thành công thì mới hiển thị giao diện điều khiển hay đôi khi chúng ta thiết kế kiểu Dashboard như trong ví dụ này.
