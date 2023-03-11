document.addEventListener("DOMContentLoaded", function() {
  //デフォルトで色を読み込んでおきたいので、"DOMContentLoaded"でHTMLを先に読み込んでいる状態を作っている
  
  let color1 = document.getElementById('color1')
  let color2 = document.getElementById('color2')
  let color3 = document.getElementById('color3')
  let color4 = document.getElementById('color4')
  //ひし形の各divのidを取得

  let colorForm1 = document.getElementById('color_form1')
  let colorForm2 = document.getElementById('color_form2')
  let colorForm3 = document.getElementById('color_form3')
  let colorForm4 = document.getElementById('color_form4')
  //カレーパレットの各idを取得

  const init = () => {  // initに始めにあてたい色を定義（init 初期設定などによく使用する単語)

      color1.style.backgroundColor = '#ff4500';  //デフォルトの色を指定
      color2.style.backgroundColor = '#ffd700';
      color3.style.backgroundColor = '#2e8b57';
      color4.style.backgroundColor = '#00bfff';
      colorForm1.addEventListener("input", applyColor1);  //各カラーパレットの色が選択された時、各applyColorアクションを実行
      colorForm2.addEventListener("input", applyColor2);  //string型で指定されているカラムに対しては"input(インプット)"を使うことが多い。
      colorForm3.addEventListener("input", applyColor3);
      colorForm4.addEventListener("input", applyColor4);

  }

  const applyColor1 = () => {
    color1.style.backgroundColor = colorForm1.value  // inputをいう動作を行った時、81行目でcolor_form1
    //console.log(colorForm1.value)  //colorForm1のメソッドを取得する
  }

  const applyColor2 = () => {
    color2.style.backgroundColor = colorForm2.value  // inputをいう動作を行った時、81行目でcolor_form1
    //console.log(colorForm1.value)  //colorForm1のメソッドを取得する
  }

  const applyColor3 = () => {
    color3.style.backgroundColor = colorForm3.value  // inputをいう動作を行った時、81行目でcolor_form1
    //console.log(colorForm1.value)  //colorForm1のメソッドを取得する
  }

  const applyColor4 = () => {
    color4.style.backgroundColor = colorForm4.value  // inputをいう動作を行った時、81行目でcolor_form1
    //console.log(colorForm1.value)  //colorForm1のメソッドを取得する
  }

  $(init);

})
