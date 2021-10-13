$TTL 3600
@       IN      SOA     dns1.nmos-tb.com. admin.nmos-tb.com. (
           20210713     ; Serial
               3600     ; Refresh
                600     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL


; DNS server
        IN      NS      dns.nmos-tb.com.

; These lines indicate to clients that this server supports DNS Service Discovery
b._dns-sd._udp  IN      PTR     @
lb._dns-sd._udp IN      PTR     @

; These lines indicate to clients which NMOS service types this server advertises:
_services._dns-sd._udp  PTR     _nmos-register._tcp
_services._dns-sd._udp  PTR     _nmos-query._tcp

_nmos-register._tcp     PTR     reg-api-1._nmos-register._tcp
_nmos-query._tcp        PTR     qry-api-1._nmos-query._tcp

; NMOS RDS services                          TTL     Class  SRV  Priority  Weight  Port  Target
reg-api-1._nmos-register._tcp.gplab.com.     3600    IN     SRV  10        10      80    rds1.nmos-tb.com.
qry-api-1._nmos-query._tcp.gplab.com.        3600    IN     SRV  10        10      80    rds1.nmos-tb.com.


; Additional metadata relevant to the IS-04 specification. See IS-04 specification section "Discovery: Registered Operation"
reg-api-1._nmos-register._tcp.gplab.com.        TXT     "api_ver=v1.0,v1.1,v1.2,v1.3" "api_proto=http" "pri=0" "api_auth=false"
qry-api-1._nmos-query._tcp.gplab.com.           TXT     "api_ver=v1.0,v1.1,v1.2,v1.3" "api_proto=http" "pri=0" "api_auth=false"

; RDS                              TTL     Class  SRV  Priority  Weight  Port  Target
_nmos-register._tcp.gplab.com.     3600    IN     SRV  10        20      80    rds1.nmos-tb.com.
_nmos-query._tcp.gplab.com.        3600    IN     SRV  10        20      80    rds1.nmos-tb.com.


; Nameserver records    Class  Type     Target
dns1.nmos-tb.com.         IN     A        10.0.50.59
rds1.nmos-tb.com.         IN     A        10.0.50.77

