import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.addEventListener("click", function (e) {
      e.preventDefault();
      document
        .querySelectorAll(".proj-capacity")
        .forEach((i) => i.classList.toggle("hidden"));
    });
  }
}
