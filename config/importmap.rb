pin "application", preload: true
pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo@8.0.4/dist/turbo.es2017-esm.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js", preload: true
pin "@hotwired/stimulus-loading", to: "https://ga.jspm.io/npm:@hotwired/stimulus-loading@1.2.0/dist/stimulus-loading.js", preload: true

pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/custom", under: "custom"
pin "swiper", to: "https://ga.jspm.io/npm:@jspm/core@2.1.0/nodelibs/@empty.js"
