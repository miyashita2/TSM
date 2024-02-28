package jp.main.servlet;

import com.google.gson.Gson;
import jp.main.model.Teacher;
import jp.main.service.TeacherService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.*;

public class UpdateServlet extends HttpServlet {
    TeacherService teacherService = new TeacherService();

    // 空のServlet
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {

        // POSTメソッドの処理
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            if (request.getParameter("update") != null) {
                // フォームから送信された値を取得
                String name = request.getParameter("name");
                int age = Integer.parseInt(request.getParameter("age"));
                String sex = request.getParameter("sex");
                String subject = request.getParameter("subject");

                // 変更前の値をデータベースから取得
                int tid = Integer.parseInt(request.getParameter("id"));
                Teacher oldTeacher = teacherService.getTeacher(tid);
                request.setAttribute("id", tid);
                // リクエスト属性に変更前と変更後の値をセット（変更がない場合はセットしない）
                if (name != null && !name.equals("") && !name.equals(oldTeacher.getName())) {
                    request.setAttribute("oldTeacherName", oldTeacher.getName());
                    request.setAttribute("newTeacherName", name);
                }
                if (age != oldTeacher.getAge()) {
                    request.setAttribute("oldTeacherAge", oldTeacher.getAge());
                    request.setAttribute("newTeacherAge", age);
                }
                if (sex != null && !sex.equals("") && !sex.equals(oldTeacher.getSex())) {
                    request.setAttribute("oldTeacherSex", oldTeacher.getSex());
                    request.setAttribute("newTeacherSex", sex);
                }
                if (subject != null && !subject.equals("") && !subject.equals(oldTeacher.getSubject())) {
                    request.setAttribute("oldTeacherSubject", oldTeacher.getSubject());
                    request.setAttribute("newTeacherSubject", subject);
                }

                // 変更がある場合のみ次のJSPにフォワード
                if (request.getAttribute("oldTeacherName") != null ||
                        request.getAttribute("oldTeacherAge") != null ||
                        request.getAttribute("oldTeacherSex") != null ||
                        request.getAttribute("oldTeacherSubject") != null) {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/teacherL/teacherUpdateConfirm.jsp");
                    dispatcher.forward(request, response);
                }

            }else if (request.getParameter("confirm") != null) {
                try {
                    // サーブレットでデータを受け取り、リクエスト属性にセットする
                    int tid = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("name");
                    String age = request.getParameter("age");
                    String sex = request.getParameter("sex");
                    String subject = request.getParameter("subject");

                    // 変更があるかを個別にチェックし、変更がある場合のみ変数に入れてJSPに渡す
                    if (name != null) {
                        request.setAttribute("oldTeacherName", teacherService.getTeacher(tid).getName());
                        request.setAttribute("newTeacherName", name);
                    }
                    if (age != null) {
                        request.setAttribute("oldTeacherAge", teacherService.getTeacher(tid).getAge());
                        request.setAttribute("newTeacherAge", age);
                    }
                    if (sex != null) {
                        request.setAttribute("oldTeacherSex", teacherService.getTeacher(tid).getSex());
                        request.setAttribute("newTeacherSex", sex);
                    }
                    if (subject != null) {
                        request.setAttribute("oldTeacherSubject", teacherService.getTeacher(tid).getSubject());
                        request.setAttribute("newTeacherSubject", subject);
                    }

                    teacherService.updateTeacher(tid, name, age, sex, subject);

                    // 更新成功の場合
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/teacherL/teacherUpdateSuccess.jsp");
                    dispatcher.forward(request, response);
                } catch (Exception e) {
                    int tid = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("id", tid);
                    // 更新に失敗した場合
                    request.setAttribute("errorMessage", "exception");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/teacherL/teacherUpdatefail.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        
    }


}