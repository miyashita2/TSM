<%@ include file="../H&F/headerInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="margin">
<p>教師番号：<%= request.getAttribute("id") %></p>
<p>名前　：<%= request.getAttribute("tname") %></p>
<p>登録が完了しました。</p>

<a href="../index.jsp" class="button a">トップページへ</a>
</div>
<%@ include file="../H&F/footerInclude.jsp" %>
