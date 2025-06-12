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
    timestamp timestamp,
    temperature_c double,
    humidity_percent double,
    solar_irradiation double,
    PRIMARY KEY (timestamp)
) WITH CLUSTERING ORDER BY (timestamp DESC);

-- Create materialized view for temperature-based queries
CREATE MATERIALIZED VIEW IF NOT EXISTS sensor_readings_by_temperature AS
SELECT timestamp, temperature_c, humidity_percent, solar_irradiation
FROM sensor_readings
WHERE temperature_c IS NOT NULL
PRIMARY KEY (temperature_c, timestamp)
WITH CLUSTERING ORDER BY (timestamp DESC);

-- Create materialized view for humidity-based queries
CREATE MATERIALIZED VIEW IF NOT EXISTS sensor_readings_by_humidity AS
SELECT timestamp, temperature_c, humidity_percent, solar_irradiation
FROM sensor_readings
WHERE humidity_percent IS NOT NULL
PRIMARY KEY (humidity_percent, timestamp)
WITH CLUSTERING ORDER BY (timestamp DESC); 