export function setupConfirmMethod() {
  Turbo.setConfirmMethod((title, element) => {
    const dialog = document.getElementById("turbo-confirm")
    const confirmType = element.getAttribute("data-turbo-confirm-type")
    const message = element.getAttribute("data-turbo-confirm-message")
    updateDialogContent(dialog, title, message, confirmType)

    showModal(dialog)

    return new Promise((resolve) => {
      dialog.addEventListener(
        "close",
        async () => {
          await handleDialogClose(dialog)
          resolve(dialog.returnValue == "confirm")
        },
        { once: true },
      )
    })
  })
}

function updateDialogContent(dialog, title, message, confirmType) {
  const confirmButton = dialog.querySelector("button[value=confirm]")

  dialog.querySelector("h3").textContent = title
  dialog.querySelector("p").textContent = "This action cannot be undone."

  if (message) {
    dialog.querySelector("p").textContent = message
  }

  confirmButton.textContent = "confirm"
  confirmButton.classList.add("btn-secondary")
  confirmButton.classList.remove("btn-danger")

  if (confirmType === "delete") {
    confirmButton.textContent = "delete"
    confirmButton.classList.remove("btn-secondary")
    confirmButton.classList.add("btn-danger")
  }
}

function showModal(dialog) {
  const dialogBackdrop = dialog.parentElement?.querySelector(
    "div[data-custom-modal-target=background]",
  )
  document.body.classList.add("overflow-hidden")
  dialog.parentElement?.classList.remove("hidden")

  dialogBackdrop?.classList.remove("hidden")
  dialogBackdrop?.classList.add("animate-fade-in")

  dialog.showModal()
}

async function handleDialogClose(dialog) {
  dialog.classList.add("animate-fade-out")
  const dialogBackdrop = dialog.parentElement?.querySelector(
    "div[data-custom-modal-target=background]",
  )
  dialogBackdrop?.classList.remove("animate-fade-in")
  dialogBackdrop?.classList.add("animate-fade-out")

  await new Promise((resolve) => setTimeout(resolve, 300))

  dialog.close()

  document.body.classList.remove("overflow-hidden")
  dialog.parentElement?.classList.add("hidden")
  dialogBackdrop?.classList.remove("animate-fade-out")
}
