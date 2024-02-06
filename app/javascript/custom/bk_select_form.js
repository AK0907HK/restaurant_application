//$(document).on('turbolinks:load', () => {

//確認用
$(document).on('change', '#prefectureSelect',function(){
    /* イベント発火時の処理 */
    $("h1").css("color", "red");
  });
  
//});  
 
  //////////////////////////////////////////////////
//$(document).on('turbolinks:load', () => {
  //セレクトボックスの中身を空にする関数
  const initSelect = ($target) => {
    //セレクトボックスの中身を空にする
    $target.empty()
    //非選択時のオプションタグを追加する
    $target.append(`<option>-----選択してください-----</option>`)
}
//セレクトボックスの中身を第二引数 data の要素を持った選択肢にする
const setSelect = ($target, data) => {
    //引数 data の値をループで１件ずつ取得し、o として取り出す
    $.each(data, (i, o) => {
        //対象となるセレクトボックス($target)に対してオプションタグを追加
        $target.append(`<option value="${o.id}">${o.city}</option>`)
    })
}

//都道府県フォームからJSONデーターを取得
// `data('json')`はjsで書くと`dataset.json`で、DOMの`data-json`の値を取る事ができる
const citiesData = $('#citySelect').data('json')

//都道府県データーを地域区分IDから絞り込む関数
const setCitiesOptions = (areaId) => {
    //地域区分IDから絞り込みを行い、変数 result に代入
    console.log(areaId);
    const result = citiesData.filter(o => o.area1_id == areaId)
    initSelect($('#citySelect'))
    setSelect($('#citySelect'), result)
}

//地域区分の値に変化があれば実行するイベント
///document.addEventListener('change',function(){
  //const areaId = e.Target.value
  //setCitiesOptions(areaId)
  //console.log(areaId);
//});

//document.addEventListener('DOMContentLoaded', function(){

//document.addEventListener('DOMContentLoaded', function(){
	document.getElementById('prefectureSelect').addEventListener('change', function(e){
    //const elem = document.getElementById('prefectureSelect');
		//const areaId = elem.value;
    //console.log(elem);
    const areaId = e.target.value
		console.log(areaId);
    setCitiesOptions(areaId)
  });
//});
	//}, false);
//}, false);

//$(document).on('change', '#prefectureSelect',function(e){
    //イベントの戻り地 `e` から選択された値を取得し、変数areaIDに代入
    
    //const areaId = e.Target.value

    //var areaId = $('option:selected').val();
    //setCitiesOptions(areaId)
    //確認用
    //console.log(areaId);
    
//});

//都道府県の値に変化があれば実行するイベント
//$('#prefectureSelect').on('change', (e) => {
    //const prefectureId = e.target.value
    //JQueryのajaxを使ってリクエストを行う dataプロパティに渡したい値を格納する
    //$.ajax('posts/search_cities', {
      //type: 'post',
      //data: { prefecture_id: prefectureId }
    //})
//})
//});
