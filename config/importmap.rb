# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

#2024/2/5追記
pin_all_from "app/javascript/custom",      under: "custom"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"

# 2024/1/12追加
#pin "swiper", to: "https://unpkg.com/swiper/swiper-bundle.min.js"
#pin "swiper-css", to: "https://unpkg.com/swiper/swiper-bundle.min.css"
#pin "swiper", to: "https://ga.jspm.io/npm:swiper@11.2.0/swiper.mjs"
#pin "swiper", to: "https://ga.jspm.io/npm:swiper@10.3.1/swiper.mjs"