package com.fakebook;

import java.util.Vector;

public class Profile {
    String firstname = null;
    String lastname = null;
    String password = null;
    String email = null;
    String security_question = null;
    String security_answer = null;
    Vector<String> subjects = new Vector<String>();
    Vector<String> research_interests = new Vector<String>();

    private void addSubject(String id) {
        subjects.addElement(id);
    }

    private void addResearchInterest(String id) {
        research_interests.addElement(id);
    }

    public void setFirstname(String s) {
        firstname = s;
    }

    public void setLastname(String s) {
        lastname = s;
    }

    public void setPassword(String s) {
        password = s;
    }

    public void setEmail(String s) {
        email = s;
    }

    public void setSecurityQuestion(String s) {
        security_question = s;
    }

    public void setSecurityAnswer(String s) {
        security_answer = s;
    }

    public String[] getSubjects() {
        String[] s = new String[subjects.size()];
        subjects.copyInto(s);
        return s;
    }

}
