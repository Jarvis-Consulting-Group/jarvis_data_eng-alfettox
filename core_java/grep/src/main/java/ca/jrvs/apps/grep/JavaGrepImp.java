package ca.jrvs.apps.grep;

import org.apache.log4j.BasicConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

public class JavaGrepImp implements JavaGrep {

  private static final Logger logger = LoggerFactory.getLogger(JavaGrep.class);
  private String regex;
  private String rootPath;
  private String outFile;

  public static void main(String[] args) {
    if (args.length != 3) {
      throw new IllegalArgumentException("Must provide: regex rootPath outFile");
    }

    BasicConfigurator.configure();
    JavaGrepImp javaGrepImp = new JavaGrepImp();
    javaGrepImp.setRegex(args[0]);
    javaGrepImp.setRootPath(args[1]);
    javaGrepImp.setOutFile(args[2]);

    try {
      javaGrepImp.process();
    } catch (Exception e) {
      logger.info("Error during process execution: ", e);
    }
  }

  @Override
  public void process() throws IOException {
    List<String> matchedLines = new ArrayList<String>();
    for (File file : listFiles(rootPath)) {
      for (String line : readLines(file)) {
        if (containsPattern(line)) {
          matchedLines.add(line);
        }
      }
    }
    writeToFile(matchedLines);
  }

  @Override
  public List<File> listFiles(String rootDir) throws IOException {
    List<File> validFiles = new ArrayList<File>();
    File curDir = new File(rootDir);
    File[] allFiles = curDir.listFiles();
    for (File f : allFiles) {
      if (f.isFile()) {
        validFiles.add(f);
      }
    }
    return validFiles;
  }

  @Override
  public List<String> readLines(File inputFile) throws IOException {
    List<String> fileLines = Files.readAllLines(
        new File(rootPath + "/" + inputFile.getName()).toPath());
    return fileLines;
  }

  @Override
  public boolean containsPatterns(String line) {
    return false;
  }

  @Override
  public boolean containsPattern(String line) {
    if (line.matches(regex)) {
      return true;
    }
    return false;
  }

  @Override
  public void writeToFile(List<String> lines) throws IOException {
    BufferedWriter writer = new BufferedWriter(new FileWriter(rootPath + "/" + outFile));
    for (String line : lines) {
      writer.write(line + "\n");
    }
    writer.close();
  }

  @Override
  public String getRootPath() {
    return this.rootPath;
  }

  @Override
  public void setRootPath() {

  }

  @Override
  public void setRootPath(String rootPath) {
    this.rootPath = rootPath;
  }

  @Override
  public String getRegex() {
    return this.regex;
  }

  @Override
  public void setRegex(String regex) {
    this.regex = regex;
  }

  @Override
  public String getOutFile() {
    return this.outFile;
  }

  @Override
  public void setOutFile(String outFile) {
    this.outFile = outFile;
  }
}