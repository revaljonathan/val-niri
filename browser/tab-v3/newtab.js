/* ── Clock ──────────────────────────────────── */
const clockEl   = document.getElementById('clock');
const secondsEl = document.getElementById('seconds');
const dateEl    = document.getElementById('date');
const days    = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
const months  = ['January','February','March','April','May','June','July','August','September','October','November','December'];

function tick() {
  const now = new Date();
  const h = String(now.getHours()).padStart(2,'0');
  const m = String(now.getMinutes()).padStart(2,'0');
  const s = String(now.getSeconds()).padStart(2,'0');
  clockEl.firstChild.textContent = `${h}:${m}`;
  secondsEl.textContent = `:${s}`;
  dateEl.textContent = `${days[now.getDay()]}, ${months[now.getMonth()]} ${now.getDate()}`;
}
tick();
setInterval(tick, 1000);

/* ── Storage helpers ────────────────────────── */
const STORAGE_KEY = 'nt_bookmarks';

const CATEGORIES = ['fun', 'serious', 'sport', 'ai', 'dump'];

const defaultBookmarks = [
  { name: 'reddit',    url: 'https://reddit.com',    cat: 'fun'     },
  { name: 'youtube',   url: 'https://youtube.com',   cat: 'fun'     },
  { name: 'github',    url: 'https://github.com',    cat: 'serious' },
];

function load() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return defaultBookmarks;
    const bms = JSON.parse(raw);
    // backfill missing cat field
    return bms.map(bm => ({ cat: 'dump', ...bm }));
  } catch { return defaultBookmarks; }
}

function save(bms) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(bms));
}

/* ── Helpers ────────────────────────────────── */
function normalizeUrl(url) {
  if (!url) return '#';
  if (!/^https?:\/\//i.test(url)) return 'https://' + url;
  return url;
}

function escHtml(s) {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

/* ── Render ─────────────────────────────────── */
const listEl = document.getElementById('bookmarks-list');

function render() {
  const bms = load();
  listEl.innerHTML = '';

  CATEGORIES.forEach(cat => {
    const group = bms
      .map((bm, i) => ({ bm, i }))
      .filter(({ bm }) => bm.cat === cat);

    if (group.length === 0) return;

    const groupEl = document.createElement('div');
    groupEl.className = 'cat-group';

    const header = document.createElement('div');
    header.className = 'cat-header';
    header.textContent = cat;
    groupEl.appendChild(header);

    group.forEach(({ bm, i }) => {
      const row = document.createElement('div');
      row.className = 'bookmark-row';

      const a = document.createElement('a');
      a.className = 'bookmark-link';
      a.href = normalizeUrl(bm.url);
      a.innerHTML =
        '<span class="bm-tilde">~</span>' +
        '<span class="bm-slash">/</span>' +
        '<span class="bm-name">' + escHtml(bm.name) + '</span>';

      a.addEventListener('dblclick', function(e) {
        e.preventDefault();
        openModal(i);
      });

      const del = document.createElement('button');
      del.className = 'bm-delete';
      del.title = 'remove';
      del.innerHTML = '&times;';
      del.addEventListener('click', function() {
        const bms2 = load();
        bms2.splice(i, 1);
        save(bms2);
        render();
      });

      row.appendChild(a);
      row.appendChild(del);
      groupEl.appendChild(row);
    });

    listEl.appendChild(groupEl);
  });
}

render();

/* ── Add ────────────────────────────────────── */
const inputName = document.getElementById('input-name');
const inputUrl  = document.getElementById('input-url');
const inputCat  = document.getElementById('input-cat');
const btnAdd    = document.getElementById('btn-add');

function addBookmark() {
  const name = inputName.value.trim().replace(/\s+/g, '-');
  const url  = inputUrl.value.trim();
  const cat  = inputCat.value;
  if (!name || !url) return;
  const bms = load();
  bms.push({ name, url, cat });
  save(bms);
  render();
  inputName.value = '';
  inputUrl.value  = '';
  inputName.focus();
}

btnAdd.addEventListener('click', addBookmark);
inputUrl.addEventListener('keydown', function(e) { if (e.key === 'Enter') addBookmark(); });
inputName.addEventListener('keydown', function(e) { if (e.key === 'Enter') inputUrl.focus(); });

/* ── Edit modal ─────────────────────────────── */
const backdrop    = document.getElementById('modal-backdrop');
const modalName   = document.getElementById('modal-name');
const modalUrl    = document.getElementById('modal-url');
const modalCat    = document.getElementById('modal-cat');
const modalSave   = document.getElementById('modal-save');
const modalCancel = document.getElementById('modal-cancel');
let editIndex = -1;

function openModal(i) {
  const bms = load();
  editIndex = i;
  modalName.value = bms[i].name;
  modalUrl.value  = bms[i].url;
  modalCat.value  = bms[i].cat || 'dump';
  backdrop.classList.add('open');
  modalName.focus();
}

function closeModal() {
  backdrop.classList.remove('open');
  editIndex = -1;
}

modalCancel.addEventListener('click', closeModal);
backdrop.addEventListener('click', function(e) {
  if (e.target === backdrop) closeModal();
});

modalSave.addEventListener('click', function() {
  if (editIndex < 0) return;
  const name = modalName.value.trim().replace(/\s+/g, '-');
  const url  = modalUrl.value.trim();
  const cat  = modalCat.value;
  if (!name || !url) return;
  const bms = load();
  bms[editIndex] = { name, url, cat };
  save(bms);
  render();
  closeModal();
});

document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') closeModal();
  if (e.key === 'Enter' && backdrop.classList.contains('open')) modalSave.click();
});
