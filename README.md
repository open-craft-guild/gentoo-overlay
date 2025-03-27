# gentoo-overlay
A collaborative Gentoo overlay by @webknjaz, @anxolerd and friends

## Adding to your system

Create file `/etc/portage/repos.conf/open-craft-guild.conf` with the following contents:

```ini
[open-craft-guild]
location = /var/repo/open-craft-guild-overlay
sync-type = git
sync-uri = https://github.com/open-craft-guild/gentoo-overlay.git
masters = gentoo
```

Sync repo with `emaint sync` or `eix-sync` and then you will be able to install packages from it.

## Maintaining

Guide on maintaining gentoo overlay: https://flewkey.com/blog/2021-03-29-gentoo-overlays-for-noobs.html
