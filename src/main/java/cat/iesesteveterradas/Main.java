package cat.iesesteveterradas;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.basex.api.client.ClientSession;
import org.basex.core.BaseXException;
import org.basex.core.cmd.Open;
import org.basex.core.cmd.XQuery;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
    private static final Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        // Initialize connection details
        String host = "127.0.0.1";
        int port = 1984;
        String username = "admin"; // Default username
        String password = "admin"; // Default password

        // Establish a connection to the BaseX server
        try (ClientSession session = new ClientSession(host, port, username, password)) {
            logger.info("Connected to BaseX server.");

            session.execute(new Open("bdComputers"));

            // Path to the directory containing .query files
            String directoryPath = "data/xquerys";
            File directory = new File(directoryPath);

            // Ensure the directory exists and is a directory
            if (directory.exists() && directory.isDirectory()) {
                // List all files in the directory
                File[] files = directory.listFiles();

                if (files != null) {
                    // Iterate over each file
                    for (File file : files) {
                        try {
                            // Read the content of the query file
                            String query = new String(Files.readAllBytes(Paths.get(file.getAbsolutePath())));

                            // Execute the query
                            String result = session.execute(new XQuery(query));

                            // Create a new file with the result
                            String outputFileName = "data/input/" + file.getName() + ".xml";
                            File outputFile = new File(outputFileName);
                            FileWriter writer = new FileWriter(outputFile);
                            writer.write(result);
                            System.out.println(result);
                            writer.close();

                            logger.info("Created XML file with result for file {}: {}", file.getName(), outputFileName);
                        } catch (IOException e) {
                            logger.error("Error reading file {}: {}", file.getName(), e.getMessage());
                        }

                    }
                }
            } else {
                logger.error("Directory {} does not exist or is not a directory.", directoryPath);
            }
        } catch (BaseXException e) {
            logger.error("Error connecting or executing the query: {}", e.getMessage());
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }
}
