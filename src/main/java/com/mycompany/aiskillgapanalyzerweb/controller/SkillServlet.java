
package com.mycompany.aiskillgapanalyzerweb.controller;

import com.mycompany.aiskillgapanalyzerweb.config.SpringConfig;
import com.mycompany.aiskillgapanalyzerweb.model.StudentSkill;
import com.mycompany.aiskillgapanalyzerweb.service.SkillService;
import com.mycompany.aiskillgapanalyzerweb.model.SkillView;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

@WebServlet("/SkillServlet")
public class SkillServlet extends HttpServlet {

    private AnnotationConfigApplicationContext context;
    private SkillService skillService;

    @Override
    public void init() throws ServletException {
        context = new AnnotationConfigApplicationContext(SpringConfig.class);
        skillService = context.getBean(SkillService.class);
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = (Integer) session.getAttribute("studentId");

        List<SkillView> skillList =
        skillService.getSkills(studentId);
        request.setAttribute("skillList", skillList);

        request.getRequestDispatcher("manage-skills.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = (Integer) session.getAttribute("studentId");

        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {

                String skillName = request.getParameter("skill_name");
                String skillLevel = request.getParameter("skill_level");

                if (skillName == null || skillLevel == null ||
                    skillName.trim().isEmpty() || skillLevel.trim().isEmpty()) {

                    response.sendRedirect("SkillServlet?error=invalid");
                    return;
                }

                boolean result = skillService.addSkill(
                        skillName.trim(), studentId, skillLevel);

                response.sendRedirect(result
                        ? "SkillServlet?success=added"
                        : "SkillServlet?error=failed");

            } else if ("update".equals(action)) {

                int id = Integer.parseInt(
                        request.getParameter("studentSkillId"));

                String level = request.getParameter("skill_level");

                boolean result = skillService.updateSkill(
                        id, studentId, level);

                response.sendRedirect(result
                        ? "SkillServlet?success=updated"
                        : "SkillServlet?error=failed");

            } else if ("delete".equals(action)) {

                int id = Integer.parseInt(
                        request.getParameter("studentSkillId"));

                boolean result = skillService.deleteSkill(id, studentId);

                response.sendRedirect(result
                        ? "SkillServlet?success=deleted"
                        : "SkillServlet?error=failed");

            } else {
                response.sendRedirect("SkillServlet?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SkillServlet?error=failed");
        }
    }

    @Override
    public void destroy() {
        if (context != null) {
            context.close();
        }
    }
}
