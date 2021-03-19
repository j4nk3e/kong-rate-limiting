Kong rate limiting
==================

General documentation:
https://docs.konghq.com/hub/kong-inc/rate-limiting/

Nginx socket API:
https://www.nginx.com/resources/wiki/modules/lua/#ngx-req-socket

Kong plugin API:
https://docs.konghq.com/gateway-oss/2.3.x/pdk/kong.client/

Kong plugin template:
https://github.com/Kong/kong-plugin



Installation:
```
cp -r rate-limiting /usr/local/share/lua/5.1/kong/plugins/
```


Example usage:
```
http post localhost:8001/plugins name:='"rate-limiting"' protocols:='["udp"]' config:='{"limit_by":"ip", "minute":5, "policy":"local"}'
```