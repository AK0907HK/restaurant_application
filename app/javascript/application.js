// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "custom/menu"
import "./controllers/linked_select"; // 連動セレクトボックス
import "./controllers/google_map";    // Google Maps

//import "custom/image_upload"
//import "custom/select_form"

import jquery from "jquery"
window.$ = jquery

//import { Swiper, SwiperSlide } from "swiper";  // 正しくSwiperをインポート
//import 'swiper/swiper-bundle.min.css';  // CSSのインポート

//import Swiper from "swiper";
//import "swiper/swiper-bundle.min.css";  // SwiperのCSS


//import Swiper from "swiper";
//import "swiper/swiper-bundle.min.css";
//import 'swiper/css';
////import Swiper from "swiper";
//import Swiper from "swiper";
//import "swiper/swiper-bundle.min.css";
//import Swiper, { Navigation, Pagination } from 'swiper';

// Import Swiper styles
//import 'swiper/css';
//import 'swiper/css/navigation';
//import 'swiper/css/pagination';