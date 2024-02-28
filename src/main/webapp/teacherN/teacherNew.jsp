<%@ include file="../H&F/headerInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<p class="titleP">教師情報登録</p>

<div class="formBox">
   <form action="/insertServlet" method="post" name="update" class="form" id="updateForm">
       <div>
           教師番号：<input type="text" name="id" size="15" value="" class="input updateInput" id="inputValue" >*
           <div id="errorDisplay" class="error"></div> <!-- エラーメッセージを表示する要素 --><br>
       </div>
           　名前　：<input type="text" name="name" size="15" value="" class="input updateInput">*<br>
           　年齢　：<input type="text" name="age" size="3" value="" class="input updateInput">*<br>
           　性別　：<input type="radio" name="sex" value="男" class="radio updateInput">男
               <input type="radio" name="sex" value="女" class="radio updateInput">女 *<br>
           <label for="subject" class="selectbox">
               　教科　：<select name="subject" id="subject" class="selectbox">
                   <option value=""></option>
                   <option value="英語">英語</option>
                   <option value="日本語">日本語</option>
                   <option value="数学">数学</option>
                   <option value="中文">中文</option>
               </select>*
           </label><br>
       <p class="newButton">*印がある項目は必須項目です。</p>
       <div class="newButton">
       <input type="submit" value="登録" name="update" class="button">
       <button type="reset" class="button">リセット</button>
       </div>
   </form>
</div>


<script type="text/javascript">
$(document).ready(function() {
    $('#inputValue').on('blur', function() {
        var inputValue = $(this).val();

        // 教師番号が空でない場合のみリクエストを送信する
        if(inputValue.trim() !== '') {
            $.ajax({
                url: '/insertServlet',
                method: 'GET',
                data: { id: inputValue },
                cache: false, // キャッシュを無効化
                success: function(response) {

                    if(response.exists) {
                        $("#errorDisplay").html("<p>この教師番号は既に存在します。</p>");
                        $('#updateForm [type="submit"]').prop('disabled', true); // フォーム内の submit ボタンを無効にする
                    } else {
                        $("#errorDisplay").html(""); // エラーメッセージを消す
                        $('#updateForm [type="submit"]').prop('disabled', false); // フォーム内の submit ボタンを有効にする
                    }
                }
            });
        } else {
            // 教師番号が空の場合、エラーメッセージを削除し、submit ボタンを無効にする
            $("#errorDisplay").html(""); // エラーメッセージを消す
            $('#updateForm [type="submit"]').prop('disabled', true); // フォーム内の submit ボタンを無効にする
        }
    });
    // フォーム送信時のイベントをキャッチ
    $('#updateForm').on('submit', function(event) {
        // エラーメッセージを格納する変数
        var errorMessage = '';

        // フォームの入力値を取得
        var idValue = $('#inputValue').val();
        var nameValue = $('input[name="name"]').val();
        var ageValue = $('input[name="age"]').val();
        var sexValue = $('input[name="sex"]:checked').val();
        var subjectValue = $('#subject').val();

        // 特殊文字のチェック
        var regex = /^[^<>(){}[\]\\\s]*$/; // <> () {} [] \ と空白以外の文字列を許可

        // 教師番号のチェック
        if (!idValue.trim() || !regex.test(idValue.trim())) {
            errorMessage += "・教師番号に特殊文字または空文字は使用できません。\n";
        }

        // 名前のチェック
        if (!nameValue.trim()) {
            errorMessage += "・名前を入力してください。\n";
        }

        // 年齢のチェック
        if (!ageValue.trim()) {
            errorMessage += "・年齢を入力してください。\n";
        }

        // 性別のチェック
        if (!sexValue) {
            errorMessage += "・性別を選択してください。\n";
        }

        // 教科のチェック
        if (!subjectValue) {
            errorMessage += "・教科を選択してください。\n";
        }

        // エラーメッセージが空でない場合、アラートで表示
        if (errorMessage !== '') {
            alert("入力エラーがあります:\n" + errorMessage);
            event.preventDefault(); // フォームのデフォルトの送信をキャンセルする
        }
    });
});
</script>
<%@ include file="../H&F/footerInclude.jsp" %>
