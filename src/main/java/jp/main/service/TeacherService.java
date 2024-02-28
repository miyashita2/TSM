package jp.main.service;

import jp.main.dao.TeacherDAO;
import jp.main.model.Teacher;

import java.sql.SQLException;
import java.util.List;

public class TeacherService {

    TeacherDAO dao = new TeacherDAO();

    public List<Teacher> getTeachers() throws SQLException {
        return dao.getTeachers();
    }
    public Teacher getTeacher(int tid) throws SQLException {
        return dao.getTeacher(tid);
    }
    public List<Teacher> search(String tid, String name, String subject) throws SQLException {
        return dao.search(tid, name, subject);
    }

    public void updateTeacher(int tid, String name, String age, String sex, String subject) throws SQLException {
        dao.updateTeacher(tid, name, age, sex, subject);
    }

    public void insert(int id, String tname, int age, String sex, String subject) throws SQLException {
        dao.insert(id, tname, age, sex, subject);
    }
}
