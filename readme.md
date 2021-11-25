# Dotfiles

Notes about the various dot files

## cntlm.conf


Generate the details for the proxy.

cntlm -u millrt9 -D apac.ent.bhpbilliton.net -H -M http://example.com


Note: Don't log into the vpn proxy before running this, otherwise you won't get a result


## Bash setup 

Since .bashrc can often be customised per distro, the best practice for these dot files
 is to source from the `.bashrc-local.bash` at the end of the existing `.bashrc`
 
This will ensure that any customisations will override the existing distro settings.

```bash
echo ". .bashrc-local.bash" >> ~/.bashrc
```

