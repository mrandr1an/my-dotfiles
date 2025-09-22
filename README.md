# Usage Notes - Documentation

## Standard Behavior Protocol

In order to be fully reproducable and bootstrap-able (which means that
a system must be able to be installed via only one command) there has
to be a standard protocol to follow so each system knows where to find
certain imporant files, especially when/if those systems interact with
eachother. This would not be a problem if the configuration aimed at a
single machine system. So the following rules are defined to have some
standard behavior.

This protocol (of sorts) assumes the existence of 1-2 desktop
configurations and possibly infinite VMs.

### Secure Files

Every system, will inevitably have important files that are stored in
this repository for safe keeping. These important files should not be
available to the public. [Agenix](https://nixos.wiki/wiki/Agenix) is
used for encryption with [age](https://github.com/FiloSottile/age) and
all the secrets are stored under the [secrets](./secrets)
directory. To decrypt those files after clonign, a system must
obviously have a private key. That private key cannot be in the
repository because it must be encrypted for security, creating an
infinite bootstrap problem.

The solution to that is that the desktop host must always have the
private key stored somehow (the somehow does not matter for the
protocol at this point, it may be an independed service such as
vaultwarden, or a usb stick that has the keys) and because the private
key will be needed during installation it must be passed by whatever 
install command/script is used to a specified location to the target
machine that will install said system. Furthermore, the private key
must be synced in case it changes in the future and a `nixos-rebuild switch`
needs to be run.

So we define the directories where the desktop and the VMs where these 
secure files are expected to be stored.

For the desktop, that is `/home/${user}/.keys`. Planning to make this
a seperate partition from an external USB.

For the virtual-machines, that is `/home/${users}/.keys`.

## Flake

[Flakes](https://wiki.nixos.org/wiki/Flakes) are part of NixOS. They
provide a uniform way to structure nix projects and much more.

My flake defines a function `mkSystem` that takes as input the inputs
of the flake and an **archetype** schema and returns a nixosSystem.

The schema is a nixos **attrset** that can either contain a _desktop_
attribute:

``` nix
  archetype = {
	desktop = desktopAttrs;
  };
```

Either contain a _virtual-machine_ attribute:

``` nix
  archetype = {
	virtual-machine = vmAttrs;
  };
```

The difference between the two attrssets lies between the hardware
configuration that is produced, since virtual-machines must be
optimized as QEMU guests. There are, however other differences.


