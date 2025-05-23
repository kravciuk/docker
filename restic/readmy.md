- **No Encryption**:
  - Removed RESTIC_PASSWORD environment variable to disable encryption.
  - The restic init command creates a repository without encryption by default when no password is set.
- **Backup Schedule**:
  - The cron job runs daily at 2 AM (0 2 * * *).
  - The script checks the day of the week with date +%w (0 = Sunday, 1 = Monday, etc.).
  - On Sunday (%w -eq 0), it runs a full backup by omitting the --parent flag.
  - On other days, it runs an incremental backup with --parent latest, referencing the most recent snapshot for efficiency.
- **Retention Policy**:
  - restic forget --keep-last 2 --prune retains only the last 2 snapshots (full or incremental) and removes unreferenced data.
  - Since full backups occur weekly, this effectively keeps the last 2 full backups and their associated incremental backups.
- **Compression**:
  - Added --compression auto to the restic backup commands to enable automatic compression, balancing speed and size.
- **Volumes**:
  - Kept the mounts for /etc, /www, /home/vadim, /var/lib/docker/volumes, and /mnt/sda1/samba/backup/local unchanged.
  - The Docker socket (/var/run/docker.sock) is included but can be removed if not needed.

### Setup Instructions

1. **Prepare the Backup Directory**:
   - Ensure /mnt/sda1/samba/backup/local exists: mkdir -p /mnt/sda1/samba/backup/local.
   - Verify permissions with ls -ld /mnt/sda1/samba/backup/local. If needed, adjust with chmod or chown (e.g., chown 1000:1000 /mnt/sda1/samba/backup/local).
2. **Deploy the Service**:
   - Save the docker-compose.yml in a directory (e.g., /opt/restic).
   - Run docker-compose up -d to start the container.
3. **Verify Backups**:
   - Check logs: docker logs restic_backup.
   - List snapshots: docker exec restic_backup restic snapshots. You should see one full backup per week and incremental backups for other days.
4. **Restore Data**:
   - To restore a snapshot, mount a restore directory (e.g., /mnt/restore) into the container by adding a volume to docker-compose.yml (e.g., /mnt/restore:/restore).
   - Run: docker exec restic_backup restic restore <snapshot_id> --target /restore.

### Additional Notes

- **Permissions**: If the container cannot write to /mnt/sda1/samba/backup/local, add user: "uid:gid" to the docker-compose.yml, matching the directory’s ownership (find with stat /mnt/sda1/samba/backup/local).
- **Full Backup Timing**: Full backups occur on Sundays (day 0). Change the condition [ \$(date +%w) -eq 0 ] to another day (e.g., 1 for Monday) if preferred.
- **Retention**: The --keep-last 2 policy keeps the last 2 snapshots, which may include incremental backups. If you want to keep only the last 2 full backups, you can use --keep-weekly 2 instead, but this may retain more incremental snapshots.
- **Compression**: The auto setting optimizes compression for speed and size. You can change to --compression max for higher compression or --compression off to disable it.
- **Security**: Since backups are unencrypted, ensure /mnt/sda1/samba/backup/local is secure (e.g., restricted permissions, no public access via Samba).
- **Cron Alternative**:
- The sleep 86400 loop runs backups daily at the container’s start time offset. To align with 2 AM, you may need to restart the container at 2 AM initially or use a host-based cron job to trigger docker exec commands.

bash:
`0 2 * * 0 docker exec restic_backup restic backup --compression auto --insecure-no-password /backup/etc /backup/www /backup/home/vadim /backup/docker_volumes && docker exec restic_backup restic forget --insecure-no-password --keep-last 2 --prune && chown -R 1000:1000 /mnt/sda1/samba/backup/local `

`0 2 * * 1-6 docker exec restic_backup restic backup --compression auto --insecure-no-password --parent latest /backup/etc /backup/www /backup/home/vadim /backup/docker_volumes && docker exec restic_backup restic forget --insecure-no-password --keep-last 2 --prune && chown -R 1000:1000 /mnt/sda1/samba/backup/local`


Get snapshot list:
`docker exec restic_backup restic snapshots --insecure-no-password`

Restore:
`docker exec restic_backup restic restore 4b82e5ed --insecure-no-password --target /restore`
