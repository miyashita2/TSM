<%@ include file="../H&F/headerInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class= "margin">
    <p>名前：<%= request.getAttribute("id") %> → <%= request.getAttribute("newTeacherName") %></p>

    <h2>変更が失敗しました。</h2>
        <p class="button margin"><a href="SearchServlet">教師一覧へ</a></p>
</div>
<%@ include file="../H&F/footerInclude.jsp" %>
