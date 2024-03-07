<%@ include file="../H&F/headerInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<p class="titleP">教師情報</p>
<div id="errorDisplay"></div> <!-- エラーメッセージを表示する要素 -->
<div class="all">
<div class="formBox">
    <form action="/SearchServlet" method="post" class="form searchForm" id="searchForm">
        教師番号：<input type="text" name="tid" size="5" id="tid" class="input">
        名前：<input type="text" name="tname" size="5" id="tname" class="input">
        <label for="subject" class="selectbox">
            コース：<select name="subject" id="subject" class="selectbox">
                <option value=""></option>
                <option value="英語">英語</option>
                <option value="日本語">日本語</option>
                <option value="数学">数学</option>
                <option value="中文">中文</option>
            </select>
        </label>
        <input type="submit" value="検索" name="insert" class="button" id="searchButton">
    </form>
</div>

<div class="textBox">
    <table border="1">
        <thead id="resultTableHead">
            <tr>
                <th>教師番号</th>
                <th>名前</th>
                <th>性別</th>
                <th>年齢</th>
                <th>コース</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody id="resultTableBody">
            <!-- 検索結果がない場合のメッセージ -->
        </tbody>
    </table>
</div>

<div class="pagination">
    <ul class="pageL" id="paginationLinks">
        <!-- ページングのリンクはスクリプトで動的に生成されるのでここには何も記述しない -->
    </ul>
</div>

<a href="../index.jsp" class="button a">トップページへ</a>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        // ページがロードされたときに最初の検索リクエストを送信する
        handleSearch();

        // 検索フォームのバリデーション
        function validateSearchForm() {
            var tid = $("#tid").val();
            if (tid.length > 5) { // 6桁以上の場合
                alert("教師番号は5桁以下で入力してください。");
                return false; // フォーム送信をキャンセル
            }
            return true; // フォーム送信を許可
        }

        // フォームの送信イベントとページネーションのクリックイベントを拾って処理を行う
        $(document).on("submit", "#searchForm", function (event) {
            event.preventDefault(); // デフォルトのフォーム送信をキャンセル
            handleSearch();
        });

        $(document).on("click", ".page-link", function (event) {
            event.preventDefault();
            handleSearch($(this).attr("data-page"));
        });

        // 検索リクエストを送信する関数
        function handleSearch(page = 1) {
            if (!validateSearchForm()) {
                return; // バリデーションに失敗したら処理を中断
            }

            var tid = $("#tid").val();
            var name = $("#tname").val();
            var subject = $("#subject").val();

            var requestData = { tid: tid, tname: name, subject: subject, page: page };

            $.ajax({
                url: "/SearchServlet",
                type: "POST",
                data: requestData,
                dataType: "json", // JSON形式でデータを受け取る
            })
            .done(function (data) {
                if (data.teachers.length > 0) {
                    // テーブルの中身をクリア
                    $("#resultTableBody").empty();

                    // JSONデータをテーブルに追加
                    $.each(data.teachers, function (index, teacher) {
                        var row = $("<tr>");
                        row.append($("<td>").text(teacher.tid));
                        row.append($("<td>").text(teacher.name));
                        row.append($("<td>").text(teacher.sex));
                        row.append($("<td>").text(teacher.age));
                        row.append($("<td>").text(teacher.subject));
                        row.append($("<td>").html("<form action='UpdateServlet' method='get'><input type='hidden' name='tid' value='" + teacher.tid + "'><input type='submit' value='変更' class='button' name='update'></form>"));
                        $("#resultTableBody").append(row);
                    });
                } else {
                    // テーブルの中身をクリア
                    $("#resultTableBody").empty();
                    
                    // メッセージを追加
                    var row = $("<tr>");
                    row.append($("<td>").attr("colspan", "6").text("該当教師がいません。"));
                    $("#resultTableBody").append(row);
                }

                // ページングリンクを動的に生成
                $("#paginationLinks").empty(); // ページングリンクをクリア

                for (var i = 1; i <= data.totalPages; i++) {
                    var pageLink = $("<li class='pageN'>");
                    if (i === data.pageNumber) {
                        pageLink.append("<span>" + i + "</span>");
                    } else {
                        pageLink.append("<a href='#' class='page-link' data-page='" + i + "'>" + i + "</a>");
                    }
                    $("#paginationLinks").append(pageLink);
                }
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                console.log("AJAX Request Failed: " + textStatus + ", " + errorThrown);
            });
        }
    });
</script>


<%@ include file="../H&F/footerInclude.jsp" %>