/* 1. Statistics on the available data */

/* Total number of GPS records. */

SELECT count (*)
FROM GPS ;


/* Wi-Fi records and their position. */

CREATE view mm_od_most_lilely_merged_wifi
as
SELECT 
	wl. user_id,
	wl.id,
	wl. time_stamp,
	wl. networkid,
	wn. longitude,
	wn. latitude,
	wn. geom
	wn. geog
FROM 
	wnetworks wn, 
	wlanrelation wl
WHERE 
	wn.id = wl. networkid;
	

/* Number of Wi-Fi records that are localized. */

-- All the WIFI records that are localized
SELECT 
	count (*)
FROM 
	mm_od_most_lilely_merged_wifi
WHERE 
	longitude IS NOT NULL

--The GPS table stores all the WLAN access points in a radius of 100m of at
--least one GPS point 
SELECT 
	count (*)
FROM 
	mm_od_most_lilely_merged_wifi
WHERE 
	networkid IN (
					SELECT DISTINCT ( nearest_wifi )
					FROM gps
				 )
				 
				 
/* GPS accuracy SQL code.*/

SELECT 
	cat,
	count (*)
FROM(
		SELECT horizontal_accuracy,
			(
				CASE
				WHEN horizontal_accuracy >= 0
					AND horizontal_accuracy < 100
					THEN 1
				WHEN horizontal_accuracy >= 100
					AND horizontal_accuracy < 200
					THEN 2
				WHEN horizontal_accuracy >= 200
					AND horizontal_accuracy < 300
					THEN 3
				WHEN horizontal_accuracy >= 300
					AND horizontal_accuracy < 400
					THEN 4
				WHEN horizontal_accuracy >= 400
					AND horizontal_accuracy < 500
					THEN 5
				WHEN horizontal_accuracy >= 500
					AND horizontal_accuracy < 600
					THEN 6
				WHEN horizontal_accuracy >= 600
					THEN 7
				END
			) cat
		FROM 
			gps
	) t1
GROUP BY cat ;


/* 2. Identfication of the trip purpose */

/* Origins and destinations traveled by bus or metro. */

SELECT 
	st_x ( from_node_geom ),
	st_y ( from_node_geom ),
	st_x ( to_node_geom ),
	st_y ( to_node_geom )
FROM 
	mm_seqs_mode
WHERE 
	mode IN (
				'bus ',
				'metro '
			)
			

/* Number of users having home and work locations inside the Lausanne agglomeration */

SELECT 
	count (*)
FROM 
	(
		SELECT 
			user_id,
			count (*)
		FROM 
			mm_centroids_homeandwork_locations
		WHERE 
			longitude < 6.8
		AND longitude > 6.5
		AND latitude < 46.6
		AND latitude > 46.45
		GROUP BY user_id
	) t1
WHERE 
	count >= 2
	

/* 3. Trip detection */

/* Wi-Fi records assigned with the meaning home and work. */

--This view contains all the WI-FI records localized for the 26 full
--time workers of our dataset on weekdays 

CREATE OR REPLACE VIEW 
	PUBLIC.mm_wifi_poi_homeandwork_locations AS
	
		SELECT 
			w. user_id,
			w. time_stamp,
			w. longitude,
			w. latitude, 
			st_distance ( 
							GEOGRAPHY 
								( 
									st_makepoint 
										(
											c. longitude, 
											c. latitude 
										)
								),
							w. geog
						) AS distance,
			c. cluster_meaning
		FROM 
			mm_od_most_lilely_merged_wifi w, 
			mm_centroids_homeandwork_locations c
		WHERE 
			w. user_id = c. user_id
		AND w. latitude IS NOT NULL
		AND (c. user_id = ANY 	( 
								ARRAY 	[5943,5944,5949,5950,5957,5959,5963,5974,59
										79,5980,6001,6002,6007,6010,6039,6040,6069,6075,6077,6090,6103,610
										4,6109,6170,6171,6198]
								)
			)
		AND 
			st_distance ( GEOGRAPHY ( st_makepoint (c. longitude , c. latitude )), w.geog ) <= c. accuracy
		AND date_part ('dow ':: TEXT , w. time_stamp ) >= 1:: DOUBLE PRECISION
		AND date_part ('dow ':: TEXT , w. time_stamp ) <= 5:: DOUBLE PRECISION
		ORDER BY 
			w. user_id,
			w. time_stamp ;





/* Home and Work trips. */

CREATE OR REPLACE 
	VIEW PUBLIC.mm_wifi_trips_homeandwork_locations AS
		SELECT 
			row_number () OVER 
								(ORDER BY 
									t4.user_id,
									t4. departure_time
								) AS trip_id, 
			t4. user_id,
			t4. departure_time,
			t4. arrival_time,
			t4. arrival_time - t4. departure_time AS travel_time,
			t4. from_location,
			t4. to_location
		FROM 
			(
				SELECT 
					t3. user_id, 
					t3. time_stamp AS departure_time,
					t3. cluster_meaning AS from_location,
					lead (t3. time_stamp ) 
										OVER 
											(
											PARTITION BY t3. user_id 
											ORDER BY t3. time_stamp
											) AS arrival_time,
					lead (t3. cluster_meaning ) 
										OVER 
											(
											PARTITION BY t3. user_id 
											ORDER BY t3. time_stamp
											) AS to_location,
					t3. is_start
				FROM 
					(
						SELECT 
						t2. user_id,
						t2. time_stamp,
						t2. cluster_meaning,
						t2. previous_cluster_meaning,
						t2. next_cluster_meaning,
						t2. is_end,
						t2. is_start
					FROM 
						(
							SELECT 
								t. user_id,
								t. time_stamp,
								t. cluster_meaning,
								t. previous_cluster_meaning,
								t. next_cluster_meaning,
								CASE
									WHEN 
										t. cluster_meaning != t. previous_cluster_meaning
									THEN 
										1
									ELSE 
										0
									END AS is_end,
								CASE
									WHEN 
										t. cluster_meaning != t. next_cluster_meaning
									THEN 
										1
									ELSE 
										0
									END AS is_start
							FROM 
								(
									SELECT 
										w. user_id,
										w. time_stamp,
										w. cluster_meaning,
										lag (w. cluster_meaning ) OVER 
																		(
																		PARTITION BY w. user_id 
																		ORDER BY w. time_stamp
																		) AS previous_cluster_meaning,
										lead (w. cluster_meaning ) OVER 
																		(
																		PARTITION BY w. user_id 
																		ORDER BY w. time_stamp
																		) AS next_cluster_meaning
									FROM 
										mm_wifi_poi_homeandwork_locations w
									ORDER BY 
										w. user_id,
										w. time_stamp
								) t
							ORDER BY 
								t. user_id,
								t. time_stamp
						) t2
					WHERE 
						t2. is_end = 1
					OR 
						t2. is_start = 1
					ORDER BY 
						t2. user_id,
						t2. time_stamp
					) t3
				ORDER BY 
					t3. user_id,
					t3. time_stamp
			) t4
		AND 
			t4. is_start = 1
		ORDER BY 
			t4. user_id,
			t4. arrival_time - t4. departure_time DESC ;