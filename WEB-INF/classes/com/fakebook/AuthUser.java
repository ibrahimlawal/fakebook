package com.fakebook;

import java.util.Vector;

public class AuthUser {
    int userid = 0;
    
    //set the user id for the currently logged in user
    //more processes may come in, hence the name
    public void processLogin(int id) {
        if (id != 0)
        	userid = id;
    }

    // logout
    private void logout() {
        userid = 0;
    }
	
	//get the user id for the currently logged in user
    public int getUserID() {
        return userid;
    }

}
