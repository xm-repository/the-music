package com.nf.advice;

import com.nf.dto.ResponseDTO;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;


//设置全局的接收日期格式
@ControllerAdvice
public class MyControllerAdvice {
    //日期时间格式
    @InitBinder
    public void myDateIniBinder(WebDataBinder dataBinder){
        DateFormatter dateFormatter = new DateFormatter();
        dateFormatter.setPattern("yy-MM-dd");
        dataBinder.addCustomFormatter(dateFormatter);
    }
    //异常处理
    @ExceptionHandler(Throwable.class)
    @ResponseBody
    public ResponseDTO handleException(Throwable ex){
        return new ResponseDTO("500",ex.getMessage(),null);
    }

}
