# Configuration Files

This folder contains various configuration files that are not applied automatically. Most of the files are just empty hulls. The effective files must be created on the Active Directory Server and copied to this directory.

* Kerberos keytab file [keytab.cmudb](keytab.cmudb) 
* Active Directory root certificate [ad_root.cer](ad_root.cer) 
* Active Directory service principle password [ad_service_password.txt](ad_service_password.txt)

Example how to create the keytab file on the Active directory server:

```bash
ktpass.exe -princ oracle/cmudb@TRIVADISLABS.COM -mapuser cmudb -pass <PASSWORD> -crypto ALL -ptype KRB5_NT_PRINCIPAL -out C:\vagrant\keytab.cmudb
```

Example how to export the root certificate on the Active directory server:

```bash
certutil -ca.cert C:\vagrant\ad_root.cer
```

Example how to get the `opwdintg.exe` from the Oracle binaries:

```bash
cp $ORACLE_HOME/bin/opwdintg.exe /u01/config/etc
```
