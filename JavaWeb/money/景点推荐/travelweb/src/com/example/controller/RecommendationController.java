package com.example.controller;

import com.example.model.Attraction;
import com.example.model.User;
import com.example.service.RecommendationService;
import com.example.service.impl.RecommendationServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/recommendations")
public class RecommendationController extends HttpServlet {
    private RecommendationService recommendationService = new RecommendationServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user != null) {
            List<Attraction> recommendations = 
                recommendationService.getRecommendations(user.getId());
            request.setAttribute("recommendations", recommendations);
        }
        
        request.getRequestDispatcher("/recommendations.jsp").forward(request, response);
    }
} 