Toolbox (git) — renamed toolbx — is a tool much like distrobox that relies on rootless podman for containerization. It’s more lightweight on resources than using a fully fledged VM and allows to optionally share the user’s home files in the host OS, among other distinct advantages like seamless access to sockets, network and removable devices, the user’s SSH agent, and so on.

It’s quite useful not only for development purposes or immutable distros, like Fedora (Atomic) Silverblue, but also to keep the host clean of packages and dependencies that might not be used in the long run. Having to manually keep containers updated, however, adds an extra maintenance burden — which can be avoided by usingsystemd to do it automatically.

Although the examples below may easily extend to other use cases, e.g., different distros or using distrobox instead, here we’ll focus on Fedora containers only.

Refresh Toolbox automatically
Let’s first make sure that the dnf cache is updated daily, so to make any commands we issue to install or update packages in the future a bit faster.

Simply create two new files in /etc/systemd/user with the content below:

#/etc/systemd/user/refresh-toolbox@.service
[Unit]
Description=Refresh dnf cache (%i)
After=network-online.target

[Service]
Type=oneshot
Environment=CONTAINER=%i
ExecStart=/usr/bin/toolbox --container "$CONTAINER" run sudo dnf makecache --quiet

[Install]
WantedBy=default.target

#/etc/systemd/user/refresh-toolbox@.timer
[Unit]
Description=Refresh dnf cache daily (%i)

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target

Once done, a timer may be enabled by issuing the following command, replacing $NAME with the appropriate variable (e.g., fedora-toolbox-40):

systemctl --user enable --now refresh-toolbox@$NAME.timer

Update Toolbox automatically
We’ll now create an additional service that will weekly update the packages on a toolbox of choice, in addition to refreshing its cache when it runs:

# /etc/systemd/user/update-toolbox@.service
[Unit]
Description=Update user Toolbox (%i)
After=network-online.target
After=refresh-toolbox@%i.service
Requires=refresh-toolbox@%i.service

[Service]
Type=oneshot
Environment=CONTAINER=%i
ExecStart=/usr/bin/toolbox --container "$CONTAINER" run sudo dnf upgrade --quiet --refresh -y

[Install]
WantedBy=default.target

# /etc/systemd/user/update-toolbox@.timer
[Unit]
Description=Update user Toolbox weekly (%i)

[Timer]
OnCalendar=weekly
Persistent=true

[Install]
WantedBy=timers.target

Like before, enable by issuing the following command, again replacing $NAME with the appropriate variable (e.g., fedora-toolbox-40):

systemctl --user enable --now update-toolbox@$NAME.timer

And that’s it! The combination of the units and timers above allows to manage distinct Fedora containers in a more flexible and automatic way.
