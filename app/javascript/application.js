// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "custom/menu"
import "custom/google_map"
import "custom/linked_select"
import "custom/swiper"
//import "./controllers/linked_select"; // 連動セレクトボックス

//import "./controllers/linked_select"; // 連動セレクトボックス
//import "./controllers/google_map";    // Google Maps
//import "./controllers/swiper_map";
//import "custom/image_upload"
//import "custom/select_form"

import jquery from "jquery"
window.$ = jquery

