import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.addLinks = document.querySelectorAll(".add_fields");
    this.removeLinks = document.querySelectorAll(".remove_fields");
    this.iterateLinks();
  }

  iterateLinks() {
    if (this.addLinks.length === 0) return;

    this.addLinks.forEach((link) => {
      link.addEventListener("click", (e) => {
        this.handleAddClick(link, e);
      });
    });

    if (this.removeLinks.length === 0) return;

    this.removeLinks.forEach((link) => {
      link.addEventListener("click", (e) => {
        this.handleRemoveClick(link, e);
      });
    });
  }

  handleAddClick(link, e) {
    if (!link || !e) return;

    e.preventDefault();

    const time = new Date().getTime();
    const linkId = link.dataset.id;
    const regexp = linkId ? new RegExp(linkId, "g") : null;
    const newFields = regexp ? link.dataset.fields.replace(regexp, time) : null;

    newFields ? link.insertAdjacentHTML("beforebegin", newFields) : null;

    for (let node of document.querySelectorAll("select.selectize")) {
      if (node.selectize === undefined) $(node).selectize();
    }
  }

  handleRemoveClick(link, e) {
    if (!link || !e) return;

    e.preventDefault();

    const fieldParent = link.closest(".nested-fields");

    const deleteField = fieldParent
      ? fieldParent.querySelector('input[type="hidden"]')
      : null;

    if (deleteField) {
      deleteField.value = 1;
      fieldParent.style.display = "none";
    }
  }
}
