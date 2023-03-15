package ca.jrvs.apps.practice;



public interface RegexExc {

    /** return true if the filename extension
     * is jpg or jpeg
     * @return
     */
    public boolean matchjpeg(String filename);


    /** return true id ip is valid
     * @param
     * @return
     */

    public boolean marchIp(String ip);


    /**
     * return true if line is empty
     * (e.g. empty, white space, tabs, etc. )
     */

    public boolean isEmptyLine(String line);












}
