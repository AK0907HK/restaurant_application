document.addEventListener("turbo:load", () => {
  const account = document.querySelector("#account");
  const dropdown = document.querySelector("#dropdown-menu");

  if (!account || !dropdown) return;

  // 重複登録を防ぐ（必要に応じて）
  if (!account.dataset.listenerAdded) {
    account.addEventListener("click", () => {
      dropdown.classList.toggle("hidden");
    });
    account.dataset.listenerAdded = "true";
  }

  document.addEventListener("click", (e) => {
    if (
      !e.target.closest("#account") &&
      !e.target.closest("#dropdown-menu")
    ) {
      dropdown.classList.add("hidden");
    }
  });
});