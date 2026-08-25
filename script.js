const menuToggle = document.querySelector('.menu-toggle');
const nav = document.querySelector('.site-nav');
const dialog = document.querySelector('.qr-dialog');

menuToggle?.addEventListener('click', () => {
  const open = nav.classList.toggle('is-open');
  menuToggle.classList.toggle('is-open', open);
  menuToggle.setAttribute('aria-expanded', String(open));
  menuToggle.setAttribute('aria-label', open ? '关闭导航' : '打开导航');
});

nav?.querySelectorAll('a').forEach((link) => {
  link.addEventListener('click', () => {
    nav.classList.remove('is-open');
    menuToggle?.classList.remove('is-open');
    menuToggle?.setAttribute('aria-expanded', 'false');
  });
});

document.querySelectorAll('[data-qr-open]').forEach((button) => {
  button.addEventListener('click', () => dialog?.showModal());
});
document.querySelector('[data-qr-close]')?.addEventListener('click', () => dialog?.close());
dialog?.addEventListener('click', (event) => {
  if (event.target === dialog) dialog.close();
});

document.querySelector('#year').textContent = new Date().getFullYear();
