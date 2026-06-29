public class Logger{
    private static volatile Logger instance;
    private Logger(){

    }
    public static Logger getInstance(){
        if(instance==null){
            instance=new Logger();
        }
        return instance;
    }
    public void logMessage(String message){
        System.out.println("LOG:"+message);
    }
}   