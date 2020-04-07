package com.nf.advice;

import org.springframework.format.datetime.DateFormatter;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.InitBinder;



//设置全局的接收日期格式
@ControllerAdvice
public class MyControllerAdvice {
    @InitBinder
    public void myDateIniBinder(WebDataBinder dataBinder){
        DateFormatter dateFormatter = new DateFormatter();
        dateFormatter.setPattern("yy-MM-dd");
        dataBinder.addCustomFormatter(dateFormatter);
    }

}
