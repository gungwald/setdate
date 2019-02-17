import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.Reader;

/**
 * Converts a text file to Apple II text file format, which means that
 * each line ends with a carriage return. The input could be a Windows
 * or Unix text file.
 */
public class Unix2Apple2 {

    public static void main(String[] args) {
        try {
            Unix2Apple2 converter = new Unix2Apple2();
            if (args.length > 0) {
                for (String arg : args) {
                    converter.convert(arg);
                }
            }
            else {
                converter.convert();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void convert() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        convert(reader);
    }

    public void convert(String fileName) throws IOException {
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(fileName));
            convert(reader);
        }
        finally {
            close(reader);
        }
    }

    public void convert(BufferedReader reader) throws IOException {
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.print(line);
            System.out.print('\r');
        }
    }

    public void close(Reader reader) {
        if (reader != null) {
            try {
                reader.close();
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

