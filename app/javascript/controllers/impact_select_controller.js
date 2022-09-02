import { Controller } from "@hotwired/stimulus";

// TODO: refactor
export default class extends Controller {
  static targets = [
    "isImpactIndicator",
    "impactType",
    "impactRigour",
    "impactLevel",
  ];

  connect() {
    let impactTypeSelect = this.impactTypeTarget;
    let impactRigourSelect = this.impactRigourTarget;
    let impactLevelSelect = this.impactLevelTarget;

    if (this.impactTypeTarget.value !== "") {
      impactRigourSelect.parentElement.classList.remove("hidden");
    }

    this.isImpactIndicatorTarget.addEventListener("change", function (e) {
      if (e.target.value === "true") {
        impactTypeSelect.parentElement.classList.remove("hidden");
      } else {
        impactTypeSelect.parentElement.classList.add("hidden");
        impactTypeSelect.value = "";
        impactRigourSelect.parentElement.classList.add("hidden");
        impactRigourSelect.options.length = 1;
        impactLevelSelect.parentElement.classList.add("hidden");
        impactLevelSelect.options.length = 1;
      }
    });

    this.impactTypeTarget.addEventListener("change", function (e) {
      if (e.target.value === "") {
        impactRigourSelect.parentElement.classList.add("hidden");
        impactRigourSelect.options.length = 1;
        impactLevelSelect.parentElement.classList.add("hidden");
        impactLevelSelect.options.length = 1;
      } else {
        fetch(`/api/impact_types/${e.target.value}/impact_rigours`)
          .then((res) => res.json())
          .then((data) => {
            impactRigourSelect.parentElement.classList.remove("hidden");
            impactRigourSelect.options.length = 1;
            impactLevelSelect.parentElement.classList.add("hidden");
            impactLevelSelect.options.length = 1;
            data.forEach(function (i) {
              let option = document.createElement("option");
              option.innerHTML = i.title;
              option.value = i.id;
              impactRigourSelect.appendChild(option);
            });
          });
      }
    });

    this.impactRigourTarget.addEventListener("change", function (e) {
      if (e.target.value === "") {
        impactLevelSelect.parentElement.classList.add("hidden");
        impactLevelSelect.options.length = 1;
      } else {
        fetch(`/api/impact_rigours/${e.target.value}/impact_levels`)
          .then((res) => res.json())
          .then((data) => {
            impactLevelSelect.parentElement.classList.remove("hidden");
            impactLevelSelect.options.length = 1;
            data.forEach(function (i) {
              let option = document.createElement("option");
              option.innerHTML = i.title;
              option.value = i.id;
              impactLevelSelect.appendChild(option);
            });
          });
      }
    });
  }
}
