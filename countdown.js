function getSeconds() {
  const searchParams = new URLSearchParams(window.location.search);

  return parseInt(searchParams.get('s') || '10', 10);
}

let seconds = getSeconds();

function countDown() {
  const count = document.getElementById('count');

  if (seconds === 0) {
    count.innerHTML = '\u{1f680}';
    return;
  }

  const newCount = count.cloneNode(true);
  newCount.innerHTML = seconds;
  count.parentNode.replaceChild(newCount, count);
  seconds -= 1;
  setTimeout(countDown, 1000);
}

document.addEventListener('DOMContentLoaded', countDown);
