 // JavaScript for dropdown toggle
 document.querySelector("#account").addEventListener("click", function () {
    const dropdown = document.querySelector("#dropdown-menu");
    dropdown.classList.toggle("hidden");
  });

  // Close dropdown if clicked outside
  document.addEventListener("click", function (e) {
    if (!e.target.closest("#account") && !e.target.closest("#dropdown-menu")) {
      const dropdown = document.querySelector("#dropdown-menu");
      dropdown.classList.add("hidden");
    }
  });