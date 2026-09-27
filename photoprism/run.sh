docker run -d \
  --name photoprism \
  --security-opt seccomp=unconfined \
  --security-opt apparmor=unconfined \
  -p 2342:2342 \
  -e PHOTOPRISM_UPLOAD_NSFW="true" \
  -e PHOTOPRISM_ADMIN_PASSWORD="iddqd" \
  -v ~/PhotoPrism/storage:/photoprism/storage \
  -v /mnt/sda1/samba/Photos:/photoprism/originals \
  photoprism/photoprism:latest
