package com.itheima.hgs.Controller;

import com.itheima.hgs.entity.Result;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;


@RestController
public class TuController {

    @RequestMapping("/tu")
    public Result tuuploadfile(@RequestPart("file") MultipartFile file) {
        if (!file.isEmpty()){
            String filename = file.getOriginalFilename();
            String subfix = filename.substring(filename.lastIndexOf("."));
            if(!".jpg".equalsIgnoreCase(subfix)){
                return new Result(false,"只能上传jpg格式文件");
            }
            String dirpath = "src/main/resources/static/images";
            File filePath = new File(dirpath);
            if(!filePath.exists()){
                filePath.mkdir();
            }
            try {
                file.transferTo(new File(filePath.getCanonicalFile()+"/"+filename));
                return new Result(true,"/images/"+filename);
            } catch (IOException e) {
                return new Result(false,"上传失败");
            }

        }
        return new Result(false,"上传失败");
    }
}
