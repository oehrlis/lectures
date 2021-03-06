----------------------------------------------------------------------------
--  Trivadis AG, Infrastructure Managed Services
--  Saegereistrasse 29, 8152 Glattbrugg, Switzerland
----------------------------------------------------------------------------
--  Name......: 10_create_pdb.sql
--  Author....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
--  Editor....: Stefan Oehrli
--  Date......: 2019.12.03
--  Usage.....: @10_create_pdb
--  Purpose...: Create a PDB (pdbsec) used for PDB security engineering
--  Notes.....: 
--  Reference.: 
--  License...: Licensed under the Universal Permissive License v 1.0 as 
--              shown at http://oss.oracle.com/licenses/upl.
----------------------------------------------------------------------------
--  Modified..:
--  see git revision history for more information on changes/updates
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- default values
DEFINE def_pdb_admin_user = "pdbadmin"
DEFINE def_pdb_admin_pwd  = "LAB01schulung"
DEFINE def_pdb_db_name    = "pdbsec"

-- define a default value for parameter if argument 1,2 or 3 is empty
SET FEEDBACK OFF
SET VERIFY OFF
COLUMN 1 NEW_VALUE 1 NOPRINT
COLUMN 2 NEW_VALUE 2 NOPRINT
COLUMN 3 NEW_VALUE 3 NOPRINT
SELECT '' "1" FROM dual WHERE ROWNUM = 0;
SELECT '' "2" FROM dual WHERE ROWNUM = 0;
SELECT '' "3" FROM dual WHERE ROWNUM = 0;
DEFINE pdb_db_name    = &1 &def_pdb_db_name
DEFINE pdb_admin_user = &2 &def_pdb_admin_user
DEFINE pdb_admin_pwd  = &3 &def_pdb_admin_pwd
COLUMN pdb_db_name NEW_VALUE pdb_db_name NOPRINT
SELECT upper('&pdb_db_name') pdb_db_name FROM dual;
-- define environment stuff
COLUMN directory_name FORMAT a25
COLUMN directory_path FORMAT a80
SET PAGESIZE 200 LINESIZE 160
COLUMN PROPERTY_NAME FORMAT a15
COLUMN PROPERTY_VALUE FORMAT a32
COLUMN DESCRIPTION FORMAT a50
SET FEEDBACK ON
CLEAR SCREEN
SET ECHO ON

---------------------------------------------------------------------------
-- 01_create_pdb.sql : prepare the PDB pdbsec
---------------------------------------------------------------------------
-- connect as SYSDBA to the root container
CONNECT / as SYSDBA
---------------------------------------------------------------------------
-- create a PDB pdbsec
CREATE PLUGGABLE DATABASE pdbsec 
    ADMIN USER pdbadmin IDENTIFIED BY LAB01schulung ROLES=(dba)
    PATH_PREFIX = '/u01/oradata/PDBSEC/directories/'
    CREATE_FILE_DEST = '/u01/oradata/PDBSEC/';
---------------------------------------------------------------------------
-- open PDB pdbsec
ALTER PLUGGABLE DATABASE pdbsec OPEN;
---------------------------------------------------------------------------
-- save state of PDB pdbsec
ALTER PLUGGABLE DATABASE pdbsec SAVE STATE;
---------------------------------------------------------------------------
-- connect to PDB as PDBADMIN
CONNECT &pdb_admin_user/&pdb_admin_pwd@&pdb_db_name
---------------------------------------------------------------------------
-- create a tablespace USERS
CREATE TABLESPACE users;
---------------------------------------------------------------------------
-- 01_create_pdb.sql : finished
---------------------------------------------------------------------------
SET ECHO OFF
-- EOF ---------------------------------------------------------------------
