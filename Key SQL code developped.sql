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