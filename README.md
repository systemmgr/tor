## tor  
  
Tor is an open source implementation of 2nd generation onion routing that provides free access to an anonymous proxy network  
  
Requires:  

```shell
sudo bash -c "$(curl -LSs https://github.com/systemmgr/installer/raw/main/install.sh)"
```

Automatic:

```shell
bash -c "$(curl -LSs https://github.com/systemmgr/tor/raw/main/install.sh)"
```

Install:

```shell
sudo systemmgr install tor
```

Update:

```shell
sudo systemmgr update tor
```

Verify:  

```shell
torsocks lynx http://check.torproject.org
```

<p align=center>
  <a href="https://wiki.archlinux.org/index.php/tor" target="_blank">tor wiki</a>  |  
  <a href="https://www.torproject.org/" target="_blank">tor site</a>
</p>  
