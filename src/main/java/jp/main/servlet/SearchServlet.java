package jp.main.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jp.main.model.Teacher;
import jp.main.service.TeacherService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class SearchServlet extends HttpServlet {
    TeacherService teacherService = new TeacherService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            // 検索条件を取得
            String tid = request.getParameter("tid");
            String name = request.getParameter("tname");
            String subject = request.getParameter("subject");

            // ページングのためのパラメータを取得
            String pageParameter = request.getParameter("page");
            int pageNumber = 1;
            if (pageParameter != null && !pageParameter.isEmpty()) {
                pageNumber = Integer.parseInt(pageParameter);
            }
            int itemsPerPage = 10;

            // 検索を実行し、結果を取得
            List<Teacher> searchResult = teacherService.search(tid, name, subject);

            // 検索結果の総数を取得
            int totalItems = searchResult.size();

            // 開始インデックスを計算
            int startIndex = (pageNumber - 1) * itemsPerPage;
            // 終了インデックスを計算
            int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

            // 現在のページの教師リストを取得
            List<Teacher> currentPageTeachers = searchResult.subList(startIndex, endIndex);

            if (request.getMethod().equalsIgnoreCase("GET")) {
                // ページング用の属性を設定
                request.setAttribute("itemList", currentPageTeachers);
                request.setAttribute("pageNumber", pageNumber);
                request.setAttribute("totalPages", (int) Math.ceil((double) totalItems / itemsPerPage));

                // 全件表示のパラメータを設定
                request.setAttribute("totalPageNumber", 1);
                request.setAttribute("totalTotalPages", (int) Math.ceil((double) totalItems / itemsPerPage));

                // JSPに転送
                request.getRequestDispatcher("/teacherL/teacherList.jsp").forward(request, response);
            } else if (request.getMethod().equalsIgnoreCase("POST")) {
                // Gsonを使用してJSON形式でデータを作成
                Gson gson = new Gson();
                String jsonTeachers = gson.toJson(currentPageTeachers);
                String jsonResponse = "{\"teachers\":" + jsonTeachers + ",\"pageNumber\":" + pageNumber + ",\"totalPages\":" + (int) Math.ceil((double) totalItems / itemsPerPage) + ",\"totalItems\":" + totalItems + "}";

                // レスポンスにJSONデータを設定
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonResponse);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

}
