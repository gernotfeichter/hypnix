# Pill 1: Android Linux PAM (alp)

This guide explains how to configure `alp` (Android Linux PAM) for passwordless `sudo` and logins. It allows your Android device to securely authenticate access to your hypnix system via a network connection (e.g., Wi-Fi).

## Prerequisites

1. An Android device running the [alp](https://github.com/gernotfeichter/alp) application.
2. Your hypnix machine's IP address should ideally be static or assigned a fixed DHCP lease.

---

## Setting up Android Linux PAM

The `alp` module handles authentication (PAM) for actions like `sudo`, `login`, and the display manager (`sddm`). 

For this purpose, the `alp.nix` file (typically located at `hardware/<machine-name>/alp.nix`) is intended. Edit your `alp.nix` to enable `alp` and point the IP address to your android device (the android app "alp" displays this):

```nix
{
  services.pam.alp = {
    enable = true;
    
    # Path to your secret key file (this file must NOT be in the Nix store!)
    keyFile = "/etc/alp/secret.key";
    
    # Enable for the actions you want to authenticate via your Android device
    enableSudo = true;
    enableLogin = true;
    enableSddm = true;
    
    # Set the targets to point to the IP:Port of your Android device running alp
    targets = [ "192.168.1.100:7654" ]; 
  };
}
```

### Initializing the Key and Pairing

1. Extract the random key generated within the `alp` android app settings.
2. Store this key securely in the file specified by `keyFile`:
   ```bash
   sudo mkdir -p /etc/alp
   sudo nano /etc/alp/secret.key
   sudo chmod 600 /etc/alp/secret.key
   ```
3. Rebuild your system configuration for the change to take effect:
   ```bash
   cd /etc/nixos && sudo -E su
   nixos-rebuild switch --impure
   ```
4. Test:
   ```bash
   sudo -k echo test
   ```

A successful authentication request via `sudo` will now trigger a prompt on your Android device.
