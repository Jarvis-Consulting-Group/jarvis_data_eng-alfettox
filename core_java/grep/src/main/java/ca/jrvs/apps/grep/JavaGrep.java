package ca.jrvs.apps.grep;

import java.io.File;
import java.io.IOException;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public interface JavaGrep {

  /**
   * Top level search workflow
   * @throws java.io.IOException
   */

  void process() throws IOException;

  /**
   * Traverse a given directory and return all files
   * @param rootDir input directory
   * @return files under the rootDir
   */

  List <File> listFiles(String rootDir);

  /**
   * check if a line contains the regex pattern (passed by user)
   * @param line input string
   * @return true if there is a match
   */

  boolean containsPatterns(String line);

  /**
   * Write lines to a file
   *
   * Explore:FileOutputStream, OutputStreamWriter, and BufferedWriter
   * @param lines matched line
   * @throws IOException if write failed
   */

  void writeToFile(List<String> lines) throws IOException;

  String getRootPath();

  void setRootPath();

  String getRegex();

  void setRegex(String regex);

  String getOutFile();

  void setOutFile(String outFile);
}
