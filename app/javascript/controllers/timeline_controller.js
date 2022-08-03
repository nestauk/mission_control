import { Controller } from "@hotwired/stimulus";
import vis from "vis-timeline";
import { DataSet } from "https://ga.jspm.io/npm:vis-data@7.1.4/peer/umd/vis-data.js";

export default class extends Controller {
  static values = {
    dataUrl: String,
    groups: Array,
  };

  connect() {
    this.csrfToken = document.querySelector("[name='csrf-token']").content;

    const options = {
      orientation: "top",
      // start: null,
      // end: null,
      groupTemplate: function (data, element) {
        element.classList.add("w-64", "text-sm");
        return data.content;
      },
      stack: true,
    };

    let groups = new DataSet(
      this.groupsValue.map((i) => {
        return { id: i, content: i };
      })
    );

    fetch(this.dataUrlValue, {
      method: "GET",
      headers: { "X-CSRF-Token": this.csrfToken },
    })
      .then((res) => res.json())
      .then((data) => {
        if (this.groupsValue.length === 0) {
          this.timeline = new vis.Timeline(
            this.element,
            new DataSet(data),
            options
          );
        } else {
          this.timeline = new vis.Timeline(
            this.element,
            new DataSet(data),
            groups,
            options
          );
        }
      });
  }
}
