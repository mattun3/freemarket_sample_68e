$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <label for="product_images_attributes_${num}_image">
                      <p>ファイルを選択</p>
                      <img src="/images/icon_camera.png" width="30" height="30">
                    </label>
                    <input class="js-file" type="file"
                    name="product[images_attributes][${num}][image]"
                    id="product_images_attributes_${num}_image">
                  </div>`;
    return html;
  }

  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">
                  <div class="js-remove">削除</div>`;
    return html;
  }
  

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  const lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('#input-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $(`div[data-index="${targetIndex}"]`).append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      
      if ($('.js-file').length < 10){
        $('#input-box').append(buildFileField(fileIndex[0]));
        // 末尾の数に1足した数を追加する
        fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
        fileIndex.shift();
      }
    }
  });

  $('#input-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index')
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();

    if ($('.js-remove').length == 9) {
     $('#input-box').append(buildFileField(fileIndex[0]));
     // 末尾の数に1足した数を追加する
     fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
     fileIndex.shift();
    }
  });
});