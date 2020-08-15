## NAME  
  
Tor is an open source implementation of 2nd generation onion routing that provides free access to an anonymous proxy network  
  
requires:    
apt: ```apt install tor```  
yum: ```yum install tor```  
pacman: ```pacman -S tor```  
  
Automatic install/update:
```
sudo bash -c "$(curl -LSs https://github.com/casjay-dotfiles/tor/raw/master/install.sh)"
```
Manual install:
```
sudo git clone https://github.com/casjay-dotfiles/tor "/usr/local/etc/tor"
sudo ln -sf /usr/local/etc/tor/site/tor-site.service /etc/systemd/system/tor-site.service
sudo ln -sf /usr/local/etc/tor/{torrc,torsocks.conf} /etc/tor/
sudo systemctl daemon-reload
sudo systemctl enable --now tor tor-site.service
sudo systemctl restart tor tor-site.service
```
Verify:  
```
torsocks lynx http://check.torproject.org
```
  
  
<p align=center>
  <a href="https://wiki.archlinux.org/index.php/tor" target="_blank">tor wiki</a>  |  
  <a href="https://www.torproject.org/" target="_blank">tor site</a>
</p>  
    
