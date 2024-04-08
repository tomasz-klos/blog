export function setupConfirmMethod() {
  Turbo.setConfirmMethod((message, element) => {
    const dialog = document.getElementById("turbo-confirm");
    const confirmType = element.getAttribute("data-turbo-confirm-type");
    updateDialogContent(dialog, message, confirmType);

    showModal(dialog);

    return new Promise((resolve) => {
      dialog.addEventListener(
        "close",
        async () => {
          await handleDialogClose(dialog);
          resolve(dialog.returnValue == "confirm");
        },
        { once: true }
      );
    });
  });
}

function updateDialogContent(dialog, message, confirmType) {
  dialog.querySelector("h3").textContent = message;

  if (confirmType === "delete") {
    const confirmButton = dialog.querySelector("button[value=confirm]");
    confirmButton.textContent = "delete";
    confirmButton.classList.remove("btn-secondary");
    confirmButton.classList.add("btn-danger");
  }
}

function showModal(dialog) {
  const dialogBackdrop = dialog.parentElement?.querySelector(
    "div[data-custom-modal-target=background]"
  );
  document.body.classList.add("overflow-hidden");
  dialog.parentElement?.classList.remove("hidden");

  dialogBackdrop?.classList.remove("hidden");
  dialogBackdrop?.classList.add("animate-fade-in");

  dialog.showModal();
}

async function handleDialogClose(dialog) {
  dialog.classList.add("animate-fade-out");
  const dialogBackdrop = dialog.parentElement?.querySelector(
    "div[data-custom-modal-target=background]"
  );
  dialogBackdrop?.classList.remove("animate-fade-in");
  dialogBackdrop?.classList.add("animate-fade-out");

  await new Promise((resolve) => setTimeout(resolve, 300));

  dialog.close();

  document.body.classList.remove("overflow-hidden");
  dialog.parentElement?.classList.add("hidden");
  dialogBackdrop?.classList.remove("animate-fade-out");
}
