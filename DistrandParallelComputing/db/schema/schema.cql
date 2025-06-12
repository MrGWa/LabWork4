-- Create keyspace for sensor data
CREATE KEYSPACE IF NOT EXISTS sensor_data
WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': 1
};

-- Use the keyspace
USE sensor_data;

-- Create table for sensor readings
CREATE TABLE IF NOT EXISTS sensor_readings (
    timestamp timestamp PRIMARY KEY,
    temperature_c double,
    humidity_percent double,
    solar_irradiation double
);

-- Create table for environment readings with detailed schema
CREATE TABLE IF NOT EXISTS environment_readings (
    id UUID,
    timestamp timestamp,
    location text,
    temperature float,
    humidity float,
    solar_irradiation float,
    temp_diff_prev float,
    humidity_diff_prev float,
    solar_irradiation_diff_prev float,
    data_source text,
    PRIMARY KEY ((id), timestamp)
) WITH CLUSTERING ORDER BY (timestamp DESC);

-- Create secondary index on location for efficient location-based queries
CREATE INDEX IF NOT EXISTS idx_location ON environment_readings (location);

DESCRIBE TABLES;

DESCRIBE TABLE sensor_readings;
DESCRIBE TABLE environment_readings;

DESCRIBE INDEXES ON environment_readings; 