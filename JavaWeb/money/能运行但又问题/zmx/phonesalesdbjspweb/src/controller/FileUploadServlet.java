package controller;

import com.alibaba.fastjson.JSON;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import utils.ResultObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "FileUploadServlet", value = "/jspviews/upload.do")
@MultipartConfig
public class FileUploadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("请求了servlet");
        //定义一个用于JSP网页端的返回对象
        ResultObject rs = new ResultObject();

        //设置返回类型为json，这很必要
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        ServletFileUpload upload = new ServletFileUpload(
                new DiskFileItemFactory());// 解析上传文件对象

        try {
            //itemList保存有从jsp中获取出来的图片的全路径名称
            List itemList = upload.parseRequest(request); //从请求对象中获得对象列表
            for (Iterator it = itemList.iterator(); it.hasNext(); ) {
                FileItem item = (FileItem) it.next();
                if (!item.isFormField())// 如果是非表单数据
                {
                    if (item.getName().length() <= 0){
                        rs.setFailureMsg("上传文件为空，上传失败");
                        String json = JSON.toJSONString(rs);
                        out.write(json);
                        out.flush(); out.close();
                        return;
                    }

                    //判断文件是否超过限制
                    if(item.getSize() >Integer.valueOf(100000000)){
                        rs.setFailureMsg("文件过大，上传失败");
                        String json = JSON.toJSONString(rs);
                        out.write(json);
                        out.flush(); out.close();
                        return;
                    }

                    //获取上传文件的原始名字
                    String originalFilename = item.getName();
                    System.out.println(originalFilename);
                    //获取文件的后缀名
                    String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));

                    //使用时间戳为文件定义新的名字
                    String uuidName = UUID.randomUUID().toString().replace("-","");

                    //为文件定义完整名字
                    String fileName = uuidName + suffix;

                    //定义文件保存位置
                    String realPath = "C:\\web_user_resource\\hotelbookingweb_resource\\" + fileName;

                    //创建虚拟目标文件
                    File destFile = new File(realPath);

                    //获得上一级目录
                    File parentFile = destFile.getParentFile();

                    if(!parentFile.exists()){
                        parentFile.mkdirs();
                    }

                    InputStream ins = item.getInputStream();
                    OutputStream ous = new FileOutputStream(destFile);
                    byte[] tmp = new byte[1024];
                    int len = -1;
                    //从上传文件对象中读取数据，并写入到创建的服务器文件中
                    while ((len = ins.read(tmp)) != -1) {
                        ous.write(tmp, 0, len);
                    }
                    ous.close();
                    ins.close();

                    rs.setSuccessMsgAndResult("文件上传成功",fileName);
                    String json = JSON.toJSONString(rs);
                    out.write(json);
                    out.flush(); out.close();
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

}
