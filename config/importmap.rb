# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "choices.js", to: "https://ga.jspm.io/npm:choices.js@10.1.0/public/assets/scripts/choices.js"
pin "vis-timeline", to: "https://ga.jspm.io/npm:vis-timeline@7.7.0/peer/umd/vis-timeline-graph2d.min.js"
pin "moment", to: "https://ga.jspm.io/npm:moment@2.29.4/moment.js"
pin "vis-data/peer/umd/vis-data.js", to: "https://ga.jspm.io/npm:vis-data@7.1.4/peer/umd/vis-data.js"
