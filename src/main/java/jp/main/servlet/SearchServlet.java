package jp.main.servlet;

import com.google.gson.Gson;
import jp.main.dao.TeacherDAO;
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
import java.util.List;


public class SearchServlet extends HttpServlet {
    TeacherService teacherService = new TeacherService();


    // 空のServlet
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 文字コードを設定する
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            List<Teacher> teacherList = teacherService.getTeachers();

            request.setAttribute("teacherList", teacherList); // リストをリクエスト属性に設定
            RequestDispatcher dispatcher = request.getRequestDispatcher("/teacherL/teacherList.jsp"); // JSPページのディスパッチャーを取得
            dispatcher.forward(request, response); // リクエストをJSPページに転送

            // 画面に表示する
            response.setContentType("text/html; charset=UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {

        // POSTメソッドの処理
        try {
            // 文字コードを設定する
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");


            String tid = request.getParameter("tid");
            tid = (tid == null || tid.isEmpty()) ? null : tid;
            String name = request.getParameter("name");
            name = (name == null || name.isEmpty()) ? null : name;
            String subject = request.getParameter("subject");
            subject = (subject == null || subject.isEmpty()) ? null : subject;
            // データがある場合は、DAOメソッドにデータを渡して処理を実行
            // データがない場合は、nullを渡す

            List<Teacher> teacherList = teacherService.search(tid, name, subject);
            if(teacherList != null){
                response.setContentType("application/json");
                Gson gson = new Gson();
                String json = gson.toJson(teacherList);
                PrintWriter out = response.getWriter();
                out.print(json);
                out.flush();
            }else{
                String error = "error";
                response.setContentType("application/json");
                Gson gson = new Gson();
                String json = gson.toJson(error);
                PrintWriter out = response.getWriter();
                out.print(json);
                out.flush();
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
