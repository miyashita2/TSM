package jp.main.model;

public class Teacher {

    // 先生のID
    private int tid;

    public int getId() {return tid;}
    public void setId(int tid) {this.tid = tid;}
    //-----------------------------------------------------------------------------------------------------
    // 先生の名前
    private String name;

    public String getName() {return name;}
    public void setName(String name) {this.name = name;}
    //-----------------------------------------------------------------------------------------------------
    // 先生の年齢
    private int age;

    public int getAge() {return age;}
    public void setAge(int age) {this.age = age;}
    //-----------------------------------------------------------------------------------------------------
    // 先生の教科
    private String subject;

    public String getSubject() {
        return subject;
    }
    public void setSubject(String subject) {
        this.subject = subject;
    }
    //-----------------------------------------------------------------------------------------------------
    // 先生の性別
    private String sex;

    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }
}
