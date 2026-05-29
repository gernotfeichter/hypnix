# Pill 1: Android Linux PAM (alp)

This guide explains how to configure `alp` (Android Linux PAM) for passwordless `sudo` and logins. It allows your Android device to securely authenticate access to your hypnix system via a network connection (e.g., Wi-Fi).

## Prerequisites

1. An Android device running the [alp](https://play.google.com/store/apps/details?id=io.github.gernotfeichter.alp) application.
2. Your android device IP address (for your local network) should ideally be static or assigned a fixed DHCP lease.

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
    # Hint: when your android phone is your Hotspot and running alp, pick this instead:
    # targets = [ "_gateway:7654" ]; 
  };
}
```

### Initializing the Key and Pairing

1. Extract the random key generated within the `alp` android app settings.
2. Store this key securely in the file specified by `keyFile`:
   ```bash
   sudo -E su
   cd /etc/nixos/hardware/<your-machine-name>
   nano secrets/alp.key
   chmod 600 secrets/alp.key
   ```
3. Rebuild your system configuration for the change to take effect:
   ```bash
   nixos-rebuild switch --impure
   ```
4. Test:
   ```bash
   exit # go back to non-root user
   sudo -k echo test
   ```

A successful authentication request via `sudo` will now trigger a prompt on your Android device.
