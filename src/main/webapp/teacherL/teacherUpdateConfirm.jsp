<%@ include file="../H&F/headerInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="margin">
    <h2>以下は変更する内容です。</h2>
    <p>教師番号<%= request.getAttribute("id") %></p>

    <%-- 変更があった場合のみ変更前と変更後の情報を表示 --%>
    <% if (request.getAttribute("newTeacherName") != null) { %>
        <p>名前：<%= request.getAttribute("oldTeacherName") %> → <%= request.getAttribute("newTeacherName") %></p>
        <br>
    <% } %>
    <% if (request.getAttribute("newTeacherAge") != null) { %>
        <p>年齢：<%= request.getAttribute("oldTeacherAge") %> → <%= request.getAttribute("newTeacherAge") %></p>
        <br>
    <% } %>
    <% if (request.getAttribute("newTeacherSex") != null) { %>
        <p>性別：<%= request.getAttribute("oldTeacherSex") %> → <%= request.getAttribute("newTeacherSex") %></p>
        <br>
    <% } %>
    <% if (request.getAttribute("newTeacherSubject") != null) { %>
        <p>科目：<%= request.getAttribute("oldTeacherSubject") %> → <%= request.getAttribute("newTeacherSubject") %></p>
        <br>
    <% } %>
    <div style="display: flex;">
        <%-- 変更があった場合のみフォームに表示 --%>
        <form action="UpdateServlet" method="post" name="confirm">
            <input type="hidden" name="id" value="<%= request.getAttribute("id") %>">
            <% if (request.getAttribute("newTeacherName") != null) { %>
                <input type="hidden" name="name" value="<%= request.getAttribute("newTeacherName") %>">
            <% } %>

            <% if (request.getAttribute("newTeacherAge") != null) { %>
                <input type="hidden" name="age" value="<%= request.getAttribute("newTeacherAge") %>">
            <% } %>

            <% if (request.getAttribute("newTeacherSex") != null) { %>
                <input type="hidden" name="sex" value="<%= request.getAttribute("newTeacherSex") %>">
            <% } %>

            <% if (request.getAttribute("newTeacherSubject") != null) { %>
                <input type="hidden" name="subject" value="<%= request.getAttribute("newTeacherSubject") %>">
            <% } %>

            <input type="submit" value="変更を確認" name="confirm" class="button">
        </form>
    <p  class="button"><a href="SearchServlet">教師一覧へ</a></p>
    </div>
</div>
<%@ include file="../H&F/footerInclude.jsp" %>