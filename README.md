# arukassr

Start

Default:

SERVER_PORT 8388
PASSWORD    p@ssw0rd
METHOD      aes-128-cfb
PROTOCOL    auth_sha1_v4_compatible
OBFS        tls1.2_ticket_auth_compatible



```
docker run -d --name arukassr -p 8989:8989 bygreencn/arukassr -s 0.0.0.0 -p 8989 -k 123456 -m aes-128-cfb -o tls1.2_ticket_auth_compatible -O auth_sha1_v4_compatible

aruka cmd 
ssserver -p 8989 -k 123456 -m aes-128-cfb -o tls1.2_ticket_auth_compatible -O auth_sha1_v4_compatible
```