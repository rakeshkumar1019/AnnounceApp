package com.yusufsezer.controller;

import com.yusufsezer.util.Helper;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("viewFile", "index.jsp");
        request.setAttribute("pageTitle", "Announce is an web based communication system for trainings, seminars and trade fairs.");
        request.setAttribute("diaryList", Helper.diaryRepository().getAll());
        request.setAttribute("userList", Helper.userRepository().getAll());
        Helper.view(request, response);
    }

}
