<%@ include file="../H&F/headerInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<p class="titleP">教師情報</p>
<div id="errorDisplay"></div> <!-- エラーメッセージを表示する要素 -->
<div class="all">
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
                        <li class="pageN"><a href="#" class="page-link" data-page="<%= i %>"><%= i %></a></li>
                    <% }
                }
            }
        %>
    </ul>
</div>

<a href="../index.jsp" class="button a">トップページへ</a>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // ページネーションのリンクがクリックされたときの処理
    $(document).on("click", ".page-link", function(event) {
        event.preventDefault();

        var page = $(this).attr("data-page");

        var tid = $("#tid").val();
        var name = $("#tname").val();
        var subject = $("#subject").val();

        var requestData = { tid: tid, tname: name, subject: subject, page: page };

        $.ajax({
            url: "/SearchServlet",
            type: "POST",
            data: requestData,
            dataType: "html",
        })
        .done(function(data) {
            $("#all").html(data);
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            console.log("AJAX Request Failed: " + textStatus + ", " + errorThrown);
        });
    });
});
</script>

<%@ include file="../H&F/footerInclude.jsp" %>