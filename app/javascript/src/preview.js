document.addEventListener('DOMContentLoaded', () => {  // HTMLが最初に読み込まれたときに作動する関数を定義
  const createImageHTML = (blob) => {  // createImageHTMLの作成
    const imageElement = document.getElementById('update_profile_image');  // getElementByIdでnew.html.erbに先ほど追加したdiv要素のid('update_profile_image')を取得
    const blobImage = document.createElement('img');  // createElementメソッドでHTML要素の「img」を作成し、blobImageに格納
    blobImage.setAttribute('class', 'edit-img')  // setAttributeでclassとsrcをimgに付与。(classを付与しているのはCSSを当てるため)
    blobImage.setAttribute('src', blob);
    imageElement.appendChild(blobImage);  // appendChildメソッドを使ってhtml.erbに追加したdiv要素の中にimg要素を入れる
  };

//   ↓ ('user_profile_image')はアプリケーションのデベロッパーツールで確認したid
  document.getElementById('user_profile_image').addEventListener('change', (e) =>{
//   ↑ 投稿フォームのファイル選択ボックスに変化（change）が起こったときに行われる処理を記述
//   ↑ アロー関数の「e」はgetElementByIdで取得した投稿フォームのファイル選択ボックスの中身になる
      const imageContent = document.querySelector('img'); 
      if (imageContent){ 
        imageContent.remove(); 
      } 

    const file = e.target.files[0];
//     ↑ e.target.files[0]で取得したファイルの情報を定数fileに格納し、URL.createObjectURL(file)で取得した情報を文字列に変換し、定数blobに格納
    const blob = window.URL.createObjectURL(file);
    createImageHTML(blob);
  });
  
})