package stonelake.fleet;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.UUID;

import javax.sql.DataSource;

import jdbchelper.JdbcHelper;
import jdbchelper.SimpleDataSource;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;

public class EpaGreenCarDataParser {

    public static void main(String[] args) {
        try {
            DataSource dataSource = new SimpleDataSource("org.hsqldb.jdbc.JDBCDriver",
                    "jdbc:hsqldb:hsql://localhost/purchasedb",
                    "SA", null);
            
            Reader in = new FileReader("C:/Users/localadmin/ca-project/GreenProject/data/all_alpha_08.csv");
            Iterable<CSVRecord> records = CSVFormat.EXCEL.withHeader().parse(in);
            
            //Clear table before re-populating
            JdbcHelper jdbc = new JdbcHelper(dataSource);
            
            //Clear the table
            /***************
            try {
                   jdbc.holdConnection();
                   jdbc.execute("delete from epa_green_vehicle");
                } finally {
                   jdbc.releaseConnection();
                }
            *****************/
            //Insert new records 
            for (CSVRecord record: records) {
                //Generate record ID
                String recordId = UUID.randomUUID().toString();
                System.out.println(recordId);
              
                //Add data elements to database

                jdbc = new JdbcHelper(dataSource);
                //Insert new record         
                try {
                       jdbc.holdConnection();
                       
                       jdbc.execute("insert into epa_green_vehicle (record_id, year ,model ,displ ,cyl ,trans ,drive ,fuel ,sales_area ,stnd ,stnd_description ,underhood_id ,veh_class ,air_pollution_score ,city_mpg ,hwy_mpg ,cmb_mpg ,greenhouse_gas_score ,smartWay) values" +
                               " (?, ?,?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?,?,?)",
                               recordId, 
                               "2008",
                               record.get("Model"),
                               record.get("Displ"), 
                               record.get("Cyl"),
                               record.get("Trans"), 
                               record.get("Drive"),
                               record.get("Fuel"), 
                               record.get("Sales Area"),
                               record.get("Stnd"),
                               record.get("Stnd Description"),
                               record.get("Underhood ID"), 
                               record.get("Veh Class"),
                               record.get("Air Pollution Score"),
                               record.get("City MPG"), 
                               record.get("Hwy MPG"),
                               record.get("Cmb MPG"), 
                               record.get("Greenhouse Gas Score"), 
                               record.get("SmartWay")
                               );
                          
/******** 2011 and newer
                       jdbc.execute("insert into epa_green_vehicle (record_id, year ,model ,displ ,cyl ,trans ,drive ,fuel ,sales_area ,stnd ,stnd_description ,underhood_id ,veh_class ,air_pollution_score ,city_mpg ,hwy_mpg ,cmb_mpg ,greenhouse_gas_score ,smartWay ,comb_CO2) values" +
                            " (?, ?,?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?,?,?,?)",
                            recordId, 
                            "2012",
                            record.get("Model"),
                            record.get("Displ"), 
                            record.get("Cyl"),
                            record.get("Trans"), 
                            record.get("Drive"),
                            record.get("Fuel"), 
                            record.get("Sales Area"),
                            record.get("Stnd"),
                            record.get("Stnd Description"),
                            record.get("Underhood ID"), 
                            record.get("Veh Class"),
                            record.get("Air Pollution Score"),
                            record.get("City MPG"), 
                            record.get("Hwy MPG"),
                            record.get("Cmb MPG"), 
                            record.get("Greenhouse Gas Score"), 
                            record.get("SmartWay"), 
                            record.get("Comb CO2")
                            );
                       
           ************/            

                       
                    } finally {
                       jdbc.releaseConnection();
                    }
            }
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}
