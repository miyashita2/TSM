<%@ include file="../H&F/headerInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<p class="titleP">教師情報</p>
<div id="errorDisplay"></div> <!-- エラーメッセージを表示する要素 -->
<div class="formBox">
<form action="/SearchServlet" method="post" class="form searchForm">
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

<div class= "textBox">
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
            <!-- ここに検索結果が表示されます -->
            <% List<Teacher> teacherList = (List<Teacher>) request.getAttribute("teacherList");
               if (teacherList != null) {
                   for (Teacher teacher : teacherList) {
            %>
            <tr>
                <td><%= teacher.getId() %></td>
                <td><%= teacher.getName() %></td>
                <td><%= teacher.getSex() %></td>
                <td><%= teacher.getAge() %></td>
                <td><%= teacher.getSubject() %></td>
                <td>
                    <form action="UpdateServlet" method="get">
                        <input type="hidden" name="tid" value="<%= teacher.getId() %>">
                        <input type="submit" value="変更" class="button" name="update">
                    </form>
                </td>
            </tr>
            <%   }
               } %>
        </tbody>
    </table>
</div>
<a href="../index.jsp" class="button a">トップページへ</a>

<script type="text/javascript">
    $(document).ready(function() {
        $(".searchForm").on("submit", function(event) {
            event.preventDefault();

            var tid = $("#tid").val();
            var name = $("#tname").val();
            var subject = $("#subject").val();
            // 入力チェック
            if (/^\d{6,}$/.test(tid)) {
                alert("教師番号は5桁以下の数字で入力してください。");
                return;
            }

            // その他の入力チェック
            var requestData = { tid: tid, name: name, subject: subject };

            $.ajax({
                url: "/SearchServlet",
                type: "POST",
                data: requestData,
                dataType: "json"
            })
            .done(function(data) {
                if (data.error) {
                    $("#errorDisplay").html("<p style='color: red;'>" + data.error + "</p>");
                    $("#resultTableBody").empty();
                } else {
                    $("#errorDisplay").empty();
                    updateTable(data);
                }
            });
        });
    });

function updateTable(data) {
    var tableBody = $("#resultTableBody");
    tableBody.empty();

    if (data.error) {
        $("#errorDisplay").html("<p style='color: red;'>" + data.error + "</p>");
    } else {
        // dataが配列であるかどうかをチェックする
        if (Array.isArray(data)) {
            // dataが配列の場合、各要素を処理する
            if (data.length > 0) {
                $.each(data, function(index, item) {
                    var row = $("<tr>");
                    row.append($("<td>").text(item.tid));
                    row.append($("<td>").text(item.name));
                    row.append($("<td>").text(item.sex));
                    row.append($("<td>").text(item.age));
                    row.append($("<td>").text(item.subject));
                    row.append("<td><form action='UpdateServlet' method='get'><input type='hidden' name='tid' value='" + item.tid + "'><input type='submit' value='変更' class='button' name='update'></form></td>");
                    tableBody.append(row);
                });
            } else {
                var row = $("<tr>");
                var msg = "該当する教師が見つかりません。";
                var colspan = 6; // 6つ分の長さを指定
                // 1つのセルを作成し、colspan属性を設定して6つのセル分の幅に広げる
                var cell = $("<td>").attr("colspan", colspan).text(msg);
                // セルを行に追加
                row.append(cell);

                tableBody.append(row);
            }
        }
    }
}
</script>

<%@ include file="../H&F/footerInclude.jsp" %>
