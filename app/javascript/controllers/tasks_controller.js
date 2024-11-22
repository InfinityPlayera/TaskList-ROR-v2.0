import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
  static targets = ["doingList", "doneList", "task"];

  startDrag(event) {
    event.dataTransfer.setData("text/plain", event.target.dataset.id);
    event.dataTransfer.effectAllowed = "move";
  }

  allowDrop(event) {
    event.preventDefault();
  }

  drop(event) {
    event.preventDefault();
    const targetList = event.target.closest("ul");
    const targetTask = event.target.closest("li");

    const draggedTaskId = event.dataTransfer.getData("text/plain");

    if(targetTask && targetTask.dataset.id !== draggedTaskId)
    {
      const completed = targetList.dataset.tasksTarget === "doingList" ? false : true;
      this.updateTaskStatus(draggedTaskId, completed);
    }
  }

  updateTaskStatus(taskId, status) {
    fetch(`/tasks/${taskId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
      },
      body: JSON.stringify({ completed: status }),
    })
    .then(response => response.json())
    .then(data => {
      window.location.href="/tasks"
    })
  }
}
