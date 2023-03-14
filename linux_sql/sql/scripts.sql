-- Giovnani De Franceschi

-- This script insert some testing data to the tables host_info and host_usage

INSERT INTO host_info
(
	hostname,
	cpu_number,
	cpu_architecture,
	cpu_model,
	cpu_mhz,
	L2_cache,
	total_mem,
	timestamp
)
VALUES (
(
	('hostname',2,'x86_64',3, 3800, 512, 512000000, 1561654651),
	('hostname2',2,'ARM',2, 1800, 512, 25600000, 561654651),
	('hostname3',2,'x86_64',3, 3800, 512, 64000000, 61654651),
	('hostname4',2,'x86_64',3, 2800, 512, 256000000, 561654951),
	('hostname5',2,'x86_64',3, 2800, 512, 128000000, 3561655651),
	('hostname6',2,'x86_64',3, 3800, 512, 512000000, 8561654651)
);


INSERT INTO hsot_usage
(
	timestamp,
	host_id, 
	memory_free,
	cpu_idle, 
	cpu_kernel,
	disk_io, 
	disk_available 
)
VALUES
(
	('2021-05-12 15:00:01', 2, 65400000, 70, 2, 500, 56534132),
	('2021-05-12 15:00:01', 2, 65400000, 70, 2, 500, 56534132),
	('2021-05-12 15:00:01', 2, 65400000, 70, 2, 500, 56534132),
	('2021-05-12 15:00:01', 2, 65400000, 70, 2, 500, 56534132),
	('2021-05-12 15:00:01', 2, 65400000, 70, 2, 500, 56534132),
	('2021-05-12 15:00:01', 2, 65400000, 70, 2, 500, 56534132),
);


-- Example of query. Select the hostnames and cpu models with a cpu_model name that begin with x86 and group the results by the hostname. 

SELECT 
	hostname, cpu_model
FROM
	host_info
WHERE
	cpu_model LIKE 'x86%'
GROUP BY hostname;

-- Retrieve the hostname and total memory for hosts with a CPU model of 3

SELECT hostname, total_mem
FROM host_info
WHERE cpu_model = 2;

-- Calculate the average L2_cache memory size for hosts with ARM architecture

SELECT AVG(L2_cache)
FROM host_info
WHERE cpu_architecture = 'ARM';


