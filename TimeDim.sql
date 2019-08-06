/*
Script Name : Time Dimension Population
Author: Arghadeep Chaudhury & Arindam Banerjee
Created On : 01-Aug-2019
Email : arghadeep.chaudhury@gmail.com
Description : This Script Would populate the Time Dimension for the Time Dim Tables.
Extension to ISO20022: Represents every hour and minute for the 24 hours in a day.
*/
--
--
--------------------------------------------------------
--  DDL for Table TM_DIM
--------------------------------------------------------
Drop table TM_DIM;

CREATE TABLE TM_DIM 
   (TIME_DIM_ID NUMBER, 
	CLNDR_TM VARCHAR2(100), 
	MIN_OF_HR_NBR NUMBER, 
	MIN_OF_DY_NBR NUMBER, 
	HR_OF_DY_NBR NUMBER, 
	SEC_OF_MIN_NBR NUMBER, 
	HR_OF_DY_NM_TXT VARCHAR2(100)
   );

   COMMENT ON COLUMN "TM_DIM"."CLNDR_TM" IS 'Calendar time indicates a three-part value representing a time of day in hours, minutes, and seconds, in the range of 00.00.00 to 23.59.59.';
   COMMENT ON COLUMN "TM_DIM"."MIN_OF_HR_NBR" IS 'Minute Of Hour identifies the elapsed number of minutes since the Hour Of Day (0, 1, 2, ..., 59). For example; 45.';
   COMMENT ON COLUMN "TM_DIM"."MIN_OF_DY_NBR" IS 'Minute Of Day identifies the elapsed number of minutes since midnight	(0, 1, 2, ..., 1439). For example; 1065.';
   COMMENT ON COLUMN "TM_DIM"."HR_OF_DY_NBR" IS 'Hour of Day identifies the elapsed number of hours since midnight (0, 1, 2, ..., 23). For example; 17.';
   COMMENT ON COLUMN "TM_DIM"."SEC_OF_MIN_NBR" IS 'Second Of Minute indicates the elapsed number of seconds since the Minute Of Hour (0, 1, 2, ..., 59). For example; 55.';
   COMMENT ON COLUMN "TM_DIM"."HR_OF_DY_NM_TXT" IS 'Hour of Day Name identifies the Hour Of Day, expressed in a textual way. For example; 5pm.';
--populate tm_dim

DECLARE
    tmp_lhour    VARCHAR2(100) := NULL;
    tmp_lmin     VARCHAR2(100) := NULL;
    tmp_lsec     VARCHAR2(100) := NULL;
    lhrofdynbtxt VARCHAR2(100) := NULL;
    l_hr_ctr     PLS_INTEGER := 0;
BEGIN
    FOR lhour IN 1 .. 24 LOOP
        FOR lmin IN 1 .. 60 LOOP
            l_hr_ctr := l_hr_ctr + 1;

            FOR lsec IN 1 .. 60 LOOP
                IF Length(lhour - 1) > 1 THEN
                  tmp_lhour := To_char(lhour - 1);
                ELSE
                  tmp_lhour := '0'
                               ||To_char(lhour - 1);
                END IF;

                IF Length(lmin - 1) > 1 THEN
                  tmp_lmin := To_char(lmin - 1);
                ELSE
                  tmp_lmin := '0'
                              ||To_char(lmin - 1);
                END IF;

                IF Length(lsec - 1) > 1 THEN
                  tmp_lsec := To_char(lsec - 1);
                ELSE
                  tmp_lsec := '0'
                              ||To_char(lsec - 1);
                END IF;

                IF lhour >= 12 THEN
                  lhrofdynbtxt := To_char(( lhour - 1 ) - 12)
                                  ||' PM';
                ELSE
                  IF lhour - 1 = 0 THEN
                    lhrofdynbtxt := '12 AM';
                  ELSE
                    lhrofdynbtxt := To_char(lhour - 1)
                                    ||' AM';
                  END IF;
                END IF;

                INSERT INTO tm_dim
                            (time_dim_id,
                             clndr_tm,
                             min_of_hr_nbr,
                             min_of_dy_nbr,
                             hr_of_dy_nbr,
                             sec_of_min_nbr,
                             hr_of_dy_nm_txt)
                VALUES      ( To_number(tmp_lhour
                                       ||tmp_lmin
                                       ||tmp_lsec),
                             tmp_lhour
                             ||'.'
                             ||tmp_lmin
                             ||'.'
                             ||tmp_lsec,
                             lmin - 1,
                             l_hr_ctr - 1,
                             lhour - 1,
                             lsec - 1,
                             lhrofdynbtxt );

                --Resetting the variables--
                tmp_lhour := NULL;

                tmp_lmin := NULL;

                tmp_lsec := NULL;

                lhrofdynbtxt := NULL;
            END LOOP;
        END LOOP;
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
      dbms_output.Put_line('error: '
                           ||SQLERRM);
END;
