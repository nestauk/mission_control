import { Controller } from "@hotwired/stimulus";
import vis from "vis-timeline";
import { DataSet } from "https://ga.jspm.io/npm:vis-data@7.1.4/peer/umd/vis-data.js";

export default class extends Controller {
  static values = {
    goalId: Number,
  };

  connect() {
    this.csrfToken = document.querySelector("[name='csrf-token']").content;

    const options = {
      orientation: "top",
    };

    fetch(`/goals/${this.goalIdValue}/objectives`, {
      method: "GET",
      headers: { "X-CSRF-Token": this.csrfToken },
    })
      .then((res) => res.json())
      .then((data) => {
        this.timeline = new vis.Timeline(
          this.element,
          new DataSet(data),
          options
        );
      });
  }
}
