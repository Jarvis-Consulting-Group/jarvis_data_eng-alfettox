package ca.jrvs.apps.grep;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Top level search workflow
 */
public interface JavaGrep {
    /**
     * Top level search workflow
     */

    void process() throws IOException;

    /**
     * Traverse a given directory and return all files
     *
     * @param rootDir input directory
     * @return files under the rootDir
     */
    List<File> listFiles(String rootDir);


    /*
     * Read ad file and return all the lines
     * FileReader: it provides a way to read files stored on the computer and manipulate the content. Create an instance of filereader than call metods
     * BufferedReader: it reads text from character-input stream. Create an instance of Buffered reader with a FileReader as an argument);
     * Character encoding: how the text characters are encoded in binary. The most used are ASCII and UTF-8
     *
     * @ param
     * @ return lines
     * @ throws IllegalArgumentException if a given inputFile is not a file
     */

    List<String> readLines(File inputFile);

    /*
    check if a line contains the regex pattern (passed by the user)
    @param line input string
    @return true id there is a match
     */
    boolean containsPattern(String line);
    /*
    write lines to a file
    FileOutputStrem:
    OutputStreamWriter:
    BufferedWriter:

    @param
    @throws
     */

    void writeToFile(List<String> lines) throws IOException;

    String getRootPath();

    void setRootPath(String rootPath);

    String getRegex();

    void setRegex(String regex);

    String getOutFile();

    void setOutFile(String outFile);
}



