<%@ include file="../H&F/headerInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="margin">
    <%-- 変更があった場合のみ変更前と変更後の情報を表示 --%>
    <% if (request.getAttribute("newTeacherName") != null) { %>
        <p>名前：<%= request.getAttribute("oldTeacherName") %> → <%= request.getAttribute("newTeacherName") %></p>
        <br>
    <% } %>
    <% if (request.getAttribute("oldTeacherAge") != null && request.getAttribute("newTeacherAge") != null) { %>
        <p>年齢：<%= request.getAttribute("oldTeacherAge") %> → <%= request.getAttribute("newTeacherAge") %></p>
        <br>
    <% } %>
    <% if (request.getAttribute("oldTeacherSex") != null && request.getAttribute("newTeacherSex") != null) { %>
        <p>性別：<%= request.getAttribute("oldTeacherSex") %> → <%= request.getAttribute("newTeacherSex") %></p>
        <br>
    <% } %>
    <% if (request.getAttribute("oldTeacherSubject") != null && request.getAttribute("newTeacherSubject") != null) { %>
        <p>科目：<%= request.getAttribute("oldTeacherSubject") %> → <%= request.getAttribute("newTeacherSubject") %></p>
        <br>
    <% } %>
    <h2>変更が完了しました</h2>
        <p class="button" style="margin:20px auto;"><a href="SearchServlet">教師一覧へ</a></p>
</div>
<%@ include file="../H&F/footerInclude.jsp" %>
