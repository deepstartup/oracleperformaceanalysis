
The attached TimeDim.sql file will create and generate :
Extension to ISO20022: Represents every hour and minute for the 24 hours in a day.

Below is the column Description :

CLNDR_TM->Calendar time indicates a three-part value representing a time of day in hours, minutes, and seconds, in the range of 00.00.00 to 23.59.59.
MIN_OF_HR_NBR->Minute Of Hour identifies the elapsed number of minutes since the Hour Of Day (0, 1, 2, ..., 59). For example; 45.
MIN_OF_DY_NBR->"Minute Of Day identifies the elapsed number of minutes since midnight	(0, 1, 2, ..., 1439). For example; 1065."
HR_OF_DY_NBR->Hour of Day identifies the elapsed number of hours since midnight (0, 1, 2, ..., 23). For example; 17.
SEC_OF_MIN_NBR->Second Of Minute indicates the elapsed number of seconds since the Minute Of Hour (0, 1, 2, ..., 59). For example; 55.
HR_OF_DY_NM_TXT->Hour of Day Name identifies the Hour Of Day, expressed in a textual way. For example; 5pm.

