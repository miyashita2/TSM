package jp.main.dao;

import jp.main.base.JdbcTest;
import jp.main.model.Teacher;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {
    //先生条件検索
    public List<Teacher> search(String tid, String name, String subject) throws SQLException {
        List<Teacher> searchList = new ArrayList<>(); // Teacherオブジェクトのリストを作成

        String sql = "SELECT * FROM teachers WHERE 1=1 ";
        // 入力されたデータがある場合のみ条件を追加
        if (tid != null && !tid.isEmpty()) {
            sql += " AND id = '" + tid + "'";
        }
        if (name != null && !name.isEmpty()) {
            // シングルクォートをエスケープして追加
            sql += " AND tname LIKE '%" + name.replace("'", "''") + "%'";
        }
        if (subject != null && !subject.isEmpty()) {
            // シングルクォートをエスケープして追加
            sql += " AND subject = '" + subject.replace("'", "''") + "'";
        }
        ResultSet res = JdbcTest.executeQuery(sql);

        while (res.next()) { // 検索結果が存在する場合
            int id = res.getInt("id");
            String tname = res.getString("tname");
            int age = res.getInt("age");
            String sex = res.getString("sex");
            String tsubject = res.getString("subject");

            Teacher te = new Teacher();
            te.setId(id);
            te.setName(tname);
            te.setAge(age);
            te.setSex(sex);
            te.setSubject(tsubject);

            searchList.add(te); // リストにTeacherオブジェクトを追加
        }
        return searchList; // Teacherオブジェクトのリストを返す
    }

    //先生全件取得
    public List<Teacher> getTeachers() throws SQLException {
        List<Teacher> teacherList = new ArrayList<>(); // Teacherオブジェクトのリストを作成

        String sql = "SELECT * FROM teachers ";
        ResultSet res = JdbcTest.executeQuery(sql);
        while (res.next()) {
            int id = res.getInt("id");
            String tname = res.getString("tname");
            int age = res.getInt("age");
            String sex = res.getString("sex");
            String subject = res.getString("subject");

            Teacher te = new Teacher();
            te.setId(id);
            te.setName(tname);
            te.setAge(age);
            te.setSex(sex);
            te.setSubject(subject);

            teacherList.add(te); // リストにTeacherオブジェクトを追加
        }
        return teacherList; // Teacherオブジェクトのリストを返す
    }
    public Teacher getTeacher(int tid) throws SQLException {

        String sql = "SELECT * FROM teachers WHERE id = "+ tid;
        ResultSet res = JdbcTest.executeQuery(sql);

        while (res.next()) {
            int id = res.getInt("id");
            String tname = res.getString("tname");
            int age = res.getInt("age");
            String sex = res.getString("sex");
            String subject = res.getString("subject");

            Teacher te = new Teacher();
            te.setId(id);
            te.setName(tname);
            te.setAge(age);
            te.setSex(sex);
            te.setSubject(subject);

            return te;
        }
        return null;
    }
    //先生変更
    public void updateTeacher(int tid, String name, String age, String sex, String subject) throws SQLException {
        // SQL 文のベース部分を設定
        String sql = "UPDATE teachers SET ";
        // 更新するカラムと値を格納するためのリスト
        List<String> updates = new ArrayList<>();

        // 各パラメータが null でない場合、更新するカラムと値をリストに追加
        if (name != null) {
            updates.add("tname='" + name + "'");
        }
        if (age != null) {
            Integer ageValue = Integer.parseInt(age);
            updates.add("age=" + ageValue);
        }
        if (sex != null) {
            updates.add("sex='" + sex + "'");
        }
        if (subject != null) {
            updates.add("subject='" + subject + "'");
        }

        // 更新するカラムと値がある場合のみ SQL 文を生成および実行
        if (!updates.isEmpty()) {
            sql += String.join(", ", updates);
            sql += " WHERE id=" + tid;
            JdbcTest.executeUpdate(sql);
        }
    }
    //先生登録
    public void insert(int id, String tname, int age, String sex, String subject) throws SQLException {
        String sql = "INSERT INTO teachers (id, tname, age, sex, subject) VALUES (?, ?, ?, ?, ?)";
        JdbcTest.executeInsert(sql, id, tname, age, sex, subject);
    }
}
