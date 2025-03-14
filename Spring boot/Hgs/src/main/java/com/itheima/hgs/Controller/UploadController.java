package com.itheima.hgs.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Controller
public class UploadController {
    @GetMapping("/upload")
    public String upload(){
        return "uploadfile";
    }

    @PostMapping("/upload")
    public String toUpload(@RequestPart("files")MultipartFile[] files, Model model) throws IOException {
        for (MultipartFile file : files){
            String filename = file.getOriginalFilename();
            if (!file.isEmpty()){
                String dirpath = "C://Users//huc.a//Desktop//111";
                file.transferTo(new File(dirpath+"//"+filename));
                model.addAttribute("msg","上传成功");
            }
        }
        return "uploadfile";
    }
}
