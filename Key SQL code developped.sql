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

--This view contains all the WI􀀀FI records localized for the 26 full
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
