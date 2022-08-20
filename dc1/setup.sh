wget https://raw.githubusercontent.com/hackyannick/samba4-dc/main/dc1/resolv.sav
apt install samba smbclient winbind krb5-user krb5-config krb5-locales winbind libpam-winbind libnss-winbind -y
mkdir /opt/smb_dc
cd /opt/smb_dc
systemctl stop samba-ad-dc.service smbd.service nmbd.service winbind.service
systemctl disable samba-ad-dc.service smbd.service nmbd.service winbind.service
smbd -b | grep "CONFIGFILE"
mv /etc/samba/smb.conf /etc/samba/smb.conf.backup
rm -rf /etc/krb5.conf
samba-tool domain provision --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL --realm=AD.HACKDV.COM --domain=AD --adminpass=7SYgdBcYH96M4r
mv /etc/krb5.conf /etc/krb5.conf.backup
ln -sf /var/lib/samba/private/krb5.conf /etc/krb5.conf
systemctl unmask samba-ad-dc.service
systemctl start samba-ad-dc.service
systemctl status samba-ad-dc.service
systemctl enable samba-ad-dc.service
rm -rf /etc/resolv.conf
chattr +i /etc/resolv.conf
reboot
