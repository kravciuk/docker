# Список портов Docker контейнеров

В данном документе перечислены все запущенные контейнеры и порты, проброшенные наружу на хост-систему (Host -> Container).

---

## 📌 Список контейнеров с открытыми портами

| Контейнер | Внешний порт (Хост) | Внутренний порт | Протокол | Образ / Описание |
| :--- | :--- | :--- | :--- | :--- |
| **angie** | `80`, `443` | `80`, `443` | TCP | `docker.angie.software/angie:latest` (Web-сервер / Reverse Proxy) |
| **authentik-server-1** | `5080`, `5443` | `9000`, `9443` | TCP | `ghcr.io/goauthentik/server:2026.5.3` (Authentik Server Web UI) |
| **backrest** | `9898` | `9898` | TCP | `ghcr.io/garethgeorge/backrest:latest` (Backrest Web UI) |
| **couchdb** | `5984` | `5984` | TCP | `couchdb:3.3.2` (CouchDB HTTP API) |
| **jellyfin** | `1900`<br>`7359`<br>`8096`<br>`8920` | `1900`<br>`7359`<br>`8096`<br>`8920` | UDP<br>UDP<br>TCP<br>TCP | `jellyfin/jellyfin` (Media Server / DLNA / Discovery / Web UI) |
| **maildev** | `1025` | `1025` | TCP | `maildev/maildev` (MailDev SMTP Server) |
| **mariadb** | `3306` | `3306` | TCP | `mariadb:latest` (MariaDB / MySQL Database) |
| **nextcloud** | `9020` | `80` | TCP | `nextcloud` (Nextcloud Web) |
| **nodecast-tv** | `3200` | `3000` | TCP | `nodecast-tv-nodecast-tv:latest` (Nodecast TV App) |
| **pgadmin** | `5050` | `80` | TCP | `dpage/pgadmin4:latest` (pgAdmin 4 Web UI) |
| **pihole** | `53`<br>`9015` | `53`<br>`80` | TCP / UDP<br>TCP | `pihole/pihole:latest` (DNS Server / Web UI) |
| **portainer** | `9000`, `9443` | `9000`, `9443` | TCP | `portainer/portainer-ce:latest` (Portainer Web UI) |
| **postgis** | `5432` | `5432` | TCP | `postgis/postgis:18-3.6` (PostgreSQL / PostGIS Database) |
| **qbit** | `6881` | `6881` | TCP / UDP | `linuxserver/qbittorrent:latest` (qBittorrent Peer Port) |
| **redis** | `6379` | `6379` | TCP | `redis:latest` (Redis Key-Value Database) |
| **redis-ui-registry-1** | `7843` | `7843` | TCP | `patrikx3/p3x-redis-ui:latest` (Redis UI Web) |
| **roundcubemail** | `9002` | `80` | TCP | `roundcube/roundcubemail:latest` (Roundcube Webmail) |
| **startpage-prod** | `7774` | `7774` | TCP | `startpage-prod` (Startpage Dashboard) |
| **wg-easy** | `51820`<br>`51821` | `51820`<br>`51821` | UDP<br>TCP | `weejewel/wg-easy` (WireGuard VPN / Web UI) |

8110 - MeTube
8120 (API), 8121 (UI)  - Rustak

---

## 🔢 Сортировка по внешним портам хоста

| Порт (Хост) | Протокол | Контейнер | Внутренний порт | Назначение |
| :--- | :--- | :--- | :--- | :--- |
| **53** | TCP / UDP | `pihole` | 53 | DNS резолвер |
| **80** | TCP | `angie` | 80 | HTTP веб-сервер |
| **443** | TCP | `angie` | 443 | HTTPS веб-сервер |
| **1025** | TCP | `maildev` | 1025 | MailDev SMTP |
| **1900** | UDP | `jellyfin` | 1900 | DLNA сервис |
| **3200** | TCP | `nodecast-tv` | 3000 | Nodecast TV |
| **3306** | TCP | `mariadb` | 3306 | MariaDB СУБД |
| **5050** | TCP | `pgadmin` | 80 | pgAdmin 4 Web |
| **5080** | TCP | `authentik-server-1` | 9000 | Authentik HTTP |
| **5432** | TCP | `postgis` | 5432 | PostgreSQL / PostGIS |
| **5443** | TCP | `authentik-server-1` | 9443 | Authentik HTTPS |
| **5984** | TCP | `couchdb` | 5984 | CouchDB API |
| **6379** | TCP | `redis` | 6379 | Redis |
| **6881** | TCP / UDP | `qbit` | 6881 | qBittorrent Torrent Peer |
| **7359** | UDP | `jellyfin` | 7359 | Jellyfin Discovery |
| **7774** | TCP | `startpage-prod` | 7774 | Startpage Dashboard |
| **7843** | TCP | `redis-ui-registry-1` | 7843 | Redis UI |
| **8096** | TCP | `jellyfin` | 8096 | Jellyfin HTTP Web UI |
| **8920** | TCP | `jellyfin` | 8920 | Jellyfin HTTPS Web UI |
| **9000** | TCP | `portainer` | 9000 | Portainer HTTP Web UI |
| **9002** | TCP | `roundcubemail` | 80 | Roundcube Webmail |
| **9015** | TCP | `pihole` | 80 | Pi-hole Web UI |
| **9020** | TCP | `nextcloud` | 80 | Nextcloud Web UI |
| **9443** | TCP | `portainer` | 9443 | Portainer HTTPS Web UI |
| **9898** | TCP | `backrest` | 9898 | Backrest Web UI |
| **51820** | UDP | `wg-easy` | 51820 | WireGuard VPN |
| **51821** | TCP | `wg-easy` | 51821 | WireGuard Easy Web UI |

---

## 🔒 Контейнеры без открытых наружу портов (работают внутри Docker-сети / проксируются через Angie)

* `authentik-worker-1` — фоновый воркер Authentik
* `drawio` — Draw.io (проксируется через Angie)
* `drawio-export` — Draw.io Export Server
* `restic_backup` — Restic Backup сервис
* `uptime-kuma` — Uptime Kuma (проксируется через Angie)
* `vaultwarden` — Vaultwarden (проксируется через Angie)