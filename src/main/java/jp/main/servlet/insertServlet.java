package jp.main.servlet;

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

public class insertServlet  extends HttpServlet {
    TeacherService teacherService = new TeacherService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            String tid = request.getParameter("id");
            String name = null;
            String subject = null;
            List<Teacher> teacherList = teacherService.search(tid, name, subject);

            // 教師番号がデータベース内に見つかったかどうかをチェック
            boolean exists = teacherList != null && !teacherList.isEmpty();

            // JSONレスポンスを作成
            String jsonResponse = "{\"exists\": " + exists + "}";

            // レスポンスを返す
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(jsonResponse);
            out.flush();


        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            // リクエストから教師番号を取得
            int id = Integer.parseInt(request.getParameter("id"));
            String tname = request.getParameter("name");
            int age = Integer.parseInt(request.getParameter("age"));
            String sex = request.getParameter("sex");
            String subject = request.getParameter("subject");

            teacherService.insert(id, tname, age, sex, subject);

            String Nid = request.getParameter("id");
            String Ntname = request.getParameter("name");
            request.setAttribute("id", Nid);
            request.setAttribute("tname", Ntname);

            // 更新成功の場合
            RequestDispatcher dispatcher = request.getRequestDispatcher("/teacherN/teacherNewSuccess.jsp");
            dispatcher.forward(request, response);
        } catch (UnsupportedEncodingException | NumberFormatException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            String Nid = request.getParameter("id");
            String Ntname = request.getParameter("name");
            // 更新に失敗した場合
            request.setAttribute("id", Nid);
            request.setAttribute("tname", Ntname);
            request.setAttribute("error", "exception");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/teacherN/teacherNewFail.jsp");
            dispatcher.forward(request, response);
        }
    }
}

