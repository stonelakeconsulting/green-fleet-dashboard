package stonelake.fleet;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.sql.DataSource;

import jdbchelper.JdbcHelper;
import jdbchelper.SimpleDataSource;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;

public class FleetDataParser {

    public static void main(String[] args) {
        try {
            DataSource dataSource = new SimpleDataSource("org.hsqldb.jdbc.JDBCDriver",
                    "jdbc:hsqldb:hsql://localhost/purchasedb",
                    "SA", null);
            
            Reader in = new FileReader("C:/Users/localadmin/ca-project/GreenProject/data/CA_State_Fleet___2011-2014_.csv");
            Iterable<CSVRecord> records = CSVFormat.EXCEL.withHeader().parse(in);
            
            //Clear table before re-populating
            JdbcHelper jdbc = new JdbcHelper(dataSource);
            
            //Clear the table 
            /**************88
            try {
                   jdbc.holdConnection();
                   jdbc.execute("delete from ca_state_fleet");
                } finally {
                   jdbc.releaseConnection();
                }
            **************/
            //Insert new records 
            for (CSVRecord record: records) {
                //Generate record ID
                String recordId = UUID.randomUUID().toString();
                
              
                //Add data elements to database

                jdbc = new JdbcHelper(dataSource);
                //Insert new record         
                try {
                       jdbc.holdConnection();

                       jdbc.execute("insert into ca_state_fleet (record_id,agency,report_year,disposed,equipment_number,category,model_year ,make_model,vin,license_plate_number,postal_code,vehicle_type_desc,weight_class,passenger_vehicle,payload_rating,shipping_weight,wheel_type,tire_size,fuel_type,engine_configuration,emissions_type,primary_application,secondary_application,acquisition_delivery_date,suv_justification,id4x4_justification,acquisition_method_reason,purchase_price,annul_lease_rate,acquistion_mileage,disposition_date,transferred_to,disposition_method,disposition_reason,disposition_mileage,disposition_sold_amount,fuel_total_fuel_average,total_miles,dec_prior_year ) values" +
                            " (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?)",
                            recordId, 
                            record.get("﻿Agency"),
                            record.get("Report Year"),
                            record.get("Disposed"),
                            record.get("Equipment Number"),
                            record.get("Category"),
                            record.get("Model Year "),
                            record.get("Make Model"),
                            record.get("VIN"),
                            record.get("License Plate Number"),
                            record.get("Postal Code"),
                            record.get("Vehicle Type Desc"),
                            record.get("Weight Class"), 
                            record.get("Passenger Vehicle On Off Road Owned Leased"),
                            record.get("Payload Rating"),
                            record.get("Shipping Weight"),
                            record.get("Wheel Type"), 
                            record.get("Tire Size"), 
                            record.get("Fuel Type"), 
                            record.get("Engine Configuration"),
                            record.get("Emissions Type"),
                            record.get("Primary Application"),
                            record.get("Secondary Application"), 
                            record.get("Acquisition Delivery Date"),
                            record.get("SUV Justification"),
                            record.get("ID4X4 Justification"), 
                            record.get("Acquisition Method Reason"),
                            record.get("Purchase Price"), 
                            record.get("Annul Lease Rate"),
                            record.get("Acquistion Mileage"),
                            record.get("Disposition Date"),
                            record.get("Transferred To"), 
                            record.get("Disposition Method"),
                            record.get("Disposition Reason"), 
                            record.get("Disposition Mileage"),
                            record.get("Disposition Sold Amount"), 
                            record.get("Fuel Total Fuel Average"), 
                            record.get("Total Miles"), 
                            record.get("Dec Prior Year ")
                            );
                       
                       

                       
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
