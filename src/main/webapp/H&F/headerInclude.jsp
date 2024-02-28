<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="jp.main.model.Teacher" %>

<!DOCTYPE html>
<html>
<head>
    <!-- ここにヘッダーのCSSやその他のリンクを追加 -->
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/reset.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>

    <!-- ここにヘッダーのコンテンツを追加 -->

