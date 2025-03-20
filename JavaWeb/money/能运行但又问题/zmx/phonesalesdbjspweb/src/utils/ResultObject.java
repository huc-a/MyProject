package utils;

/**
 * 用于封装来自Controller的返回内容
 */
public class ResultObject {
    public int code;  //执行成功的状态
    public String msg; //执行后的消息
    public Object result; //存储执行后的结果

    public static final int SUCCESS = 0;
    public static final int FAILURE = 1;

    public void setFailureMsg(String msg){
        this.code = FAILURE;
        this.msg = msg;
    }

    public void setSuccessMsg(String msg){
        this.code = SUCCESS;
        this.msg = msg;
    }

    public void setSuccessMsgAndResult(String msg,Object resultconent){
        this.code = SUCCESS;
        this.msg = msg;
        this.result = resultconent;
    }
}
