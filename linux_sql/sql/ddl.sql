
--psql

-- Giovanni De Franceschi

\c host_agent


--create table to store the node specifications
CREATE TABLE IF NOT EXISTS PUBLIC.host_info 
 ( 
     id               SERIAL NOT NULL, 
     hostname         VARCHAR NOT NULL, 
     cpu_number       INT2 NOT NULL, 
     cpu_architecture VARCHAR NOT NULL, 
     cpu_model        VARCHAR NOT NULL, 
     cpu_mhz          FLOAT8 NOT NULL, 
     l2_cache         INT4 NOT NULL, 
     "timestamp"      TIMESTAMP NULL, 
     total_mem        INT4 NULL, 

     CONSTRAINT host_info_pk PRIMARY KEY (id) 
     
);


-- craeate a table to store the usage of the resources
CREATE TABLE IF NOT EXISTS PUBLIC.host_usage
(
	id 		SERIAL PRIMARY KEY,
	timestamp 	TIMESTAMP NOT NULL,
	host_id 	INTEGER NOT NULL,
	memory_free 	INTEGER,
	cpu_idle	INTEGER,
	cpu_kernel 	INTEGER,
	disk_io 	INTEGER,
	disk_available  INTEGER,
	
	CONSTRAINT foreign_key_host_id
		FOREIGN KEY(host_id)
		REFERENCES PUBLIC.host_info(id)
);
