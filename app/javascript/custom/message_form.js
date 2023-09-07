// const btn3 = document.getElementById('btn3');
// const mask = document.getElementById('mask');
// const modal = document.getElementById('modal');

// btn3.addEventListener('click', () => {
//   mask.classList.remove('hidden');
//   modal.classList.remove('hidden');
// });

// mask.addEventListener('click', () => {
//   mask.classList.add('hidden');
//   modal.classList.add('hidden');
// });


const modal = document.querySelector('.js-modal');
const modalButton = document.querySelector('.js-modal-button');

// 追記
const modalClose = document.querySelector('.js-close-button');　// xボタンのjs-close-buttonを取得し変数に格納

modalButton.addEventListener('click', () => {
  modal.classList.add('is-open');
});

// 追記
modalClose.addEventListener('click', () => { // xボタンをクリックしたときのイベントを登録
  modal.classList.remove('is-open'); 
});