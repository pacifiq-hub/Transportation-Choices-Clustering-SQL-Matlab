/* 1. Statistics on the available data */

/*
The number of GPS records recorded during the campaign is obtained with the following SQL
code:
*/
SELECT count (*)
FROM GPS ;


/*
An important view for the project assigns to every record of the wlanrelation table its positional
coordinates stored in the wnetworks table when they are available:
*/
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
	

/* All the WIFI records that are localized*/
SELECT 
	count (*)
FROM 
	mm_od_most_lilely_merged_wifi
WHERE 
	longitude IS NOT NULL

/*The GPS table stores all the WLAN access points in a radius of 100m of at
least one GPS point */
SELECT 
	count (*)
FROM 
	mm_od_most_lilely_merged_wifi
WHERE 
	networkid IN (
					SELECT DISTINCT ( nearest_wifi )
					FROM gps
				 )
				 
				 
/* For the histogram on GPS accuracy, as 14 millions records had to be split into four categories,
we first used the following SQL code */

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


/* 1. Identfication of the trip purpose */
