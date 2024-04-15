document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("#new_tweet");

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    debugger
    const formData = new FormData(form);

    fetch(form.action, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
        "Accept": "application/json",
      },
      body: formData,
    })
    .then(response => response.json())
    .then(tweet => {
      const tweetDiv = document.createElement("div");
      tweetDiv.classList.add("tweet");
      tweetDiv.innerHTML = `<span class="username">Posted by: ${tweet.user.username}</span><br>${tweet.content}`;
      document.querySelector("#tweets").prepend(tweetDiv);
      form.reset();
    })
    .catch(error => console.error("Error:", error));
  });

  document.querySelectorAll("a[data-remote]").forEach(link => {
    link.addEventListener("ajax:success", (event) => {
      const tweetDiv = event.target.closest(".tweet");
      tweetDiv.remove();
    });
  });
});
