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
            <% List<Teacher> itemList = (List<Teacher>) request.getAttribute("itemList");
               if (itemList != null) {
                   for (Teacher teacher : itemList) {
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

    <div class="pagination">
        <ul class="pageL">
            <%
                // ページングの属性を取得
                Integer pageNumber = (Integer) request.getAttribute("pageNumber");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                if (pageNumber != null && totalPages != null && totalPages > 1) {
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == pageNumber) { %>
                            <li class="pageN"><span><%= i %></span></li>
                        <% } else { %>
                            <li class="pageN"><a href="<%= request.getContextPath() %>/SearchServlet?page=<%= i %>"><%= i %></a></li>
                        <% }
                    }
                }
            %>
        </ul>
    </div>

<a href="../index.jsp" class="button a">トップページへ</a>

<script type="text/javascript">
$(document).ready(function() {
    $(".searchForm").on("submit", function(event) {
        event.preventDefault();

        var tid = $("#tid").val();
        var name = $("#tname").val();
        var subject = $("#subject").val();

        // どれか一つでも入力されていれば検索可能とする
        if (!tid && !name && !subject) {
            alert("検索条件を入力してください。");
            return;
        }

        // 入力チェック
        if (tid && !/^\d{1,5}$/.test(tid)) {
            alert("教師番号は1桁以上5桁以下の数字で入力してください。");
            return;
        }

        // その他の入力チェック
        var requestData = { tid: tid, tname: name, subject: subject };

        $.ajax({
            url: "/SearchServlet",
            type: "POST",
            data: requestData,
            dataType: "html", // サーバーからの応答のデータタイプをHTMLに変更
        })
        .done(function(data) {
            // 既存のテーブルを置き換える
            $("#resultTableBody").html(data);
            console.log(data);
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            console.log("AJAX Request Failed: " + textStatus + ", " + errorThrown);
            // Handle error gracefully, such as displaying an error message to the user
        });
    });

});

</script>

<%@ include file="../H&F/footerInclude.jsp" %>
