<%@ include file="../H&F/headerInclude.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>


<p class="titleP">教師情報変更</p>
<% List<Teacher> teacherList = (List<Teacher>) request.getAttribute("teacherList");
   if (teacherList != null) {
       for (Teacher teacher : teacherList) {
%>
<div class="formBox">
   <form action="UpdateServlet" method="post" name="update" class="form"
   onsubmit="return checkChanges('<%= teacher.getName() %>', '<%= teacher.getAge() %>', '<%= teacher.getSex() %>', '<%= teacher.getSubject() %>')">
       <input type = "hidden" name = "id" value ="<%= teacher.getId() %>"class="input">
        <p>教師番号<%= teacher.getId() %></p>
            名前：<input type="text" name="name" size="20" value="<%= teacher.getName() %>" required class="input updateInput"><br>
            年齢：<input type="text" name="age" size="3" value="<%= teacher.getAge() %>" required class="input updateInput"><br>
            性別：<input type="radio" name="sex" value="男" <%= teacher.getSex().equals("男") ? "checked" : "" %> required class="radio updateInput">男
                <input type="radio" name="sex" value="女" <%= teacher.getSex().equals("女") ? "checked" : "" %> class="radio updateInput">女<br>
            <label for="subject" class="selectbox">
                コース：<select name="subject" id="subject" class="selectbox">
                    <option value=""></option>
                    <option value="英語" <%= teacher.getSubject().equals("英語") ? "selected" : "" %>>英語</option>
                    <option value="日本語" <%= teacher.getSubject().equals("日本語") ? "selected" : "" %>>日本語</option>
                    <option value="数学" <%= teacher.getSubject().equals("数学") ? "selected" : "" %>>数学</option>
                    <option value="中文" <%= teacher.getSubject().equals("中文") ? "selected" : "" %>>中文</option>
                </select>
            </label><br>
       <input type="submit" value="更新" name = "update" class="button">
       <button type="reset" class="button">リセット</button>
   </form>
</div>
    <%
        }
    }
    %>

<script>
function checkChanges(name, age, sex, subject) {
    // 各入力フィールドの現在の値を取得
    var nameInput = document.getElementsByName('name')[0].value;
    var ageInput = document.getElementsByName('age')[0].value;
    var sexInput = document.querySelector('input[name="sex"]:checked').value;
    var subjectInput = document.getElementsByName('subject')[0].value;

    // フォームの各値と元の値を比較して変更があるかどうかを確認
    if (nameInput !== name || ageInput !== age || sexInput !== sex || subjectInput !== subject) {
        // 変更がある場合はフォームを送信
        return true;
    } else {
        // 変更がない場合は送信をキャンセル
        alert('変更がありません');
        return false;
    }
}
</script>
<%@ include file="../H&F/footerInclude.jsp" %>
