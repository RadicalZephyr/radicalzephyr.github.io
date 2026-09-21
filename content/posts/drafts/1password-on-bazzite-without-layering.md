+++
layout = "post"
title = "1Password on Bazzite: SSH agent and CLI without layering"
categories = ["Linux", "Bazzite", "1Password"]
comments = true
draft = true
+++

I wanted two things from 1Password on my Bazzite desktop: the SSH agent, and the `op`
CLI talking to the desktop app so I don't have to sign in separately. I had the Flatpak,
which does neither. My plan was to try the RPM under `rpm-ostree usroverlay` and see if
it was worth layering. That plan was wrong in two places, and the thing that actually
works is a Homebrew cask I didn't know existed. This is the short version, with the dead
ends left in so they show up when you search for them.

<!--more-->

## The Flatpak can't do it, and that's by design

1Password's own [SSH docs][1password-ssh] say it plainly: the agent doesn't work with Flatpak or Snap
installs. The CLI integration is out too. `op` finds the app through a helper binary that
has to be root-owned and setgid to a dedicated group, and a sandbox can't hand you that.
The Flatpak *contains* the helper and `op-ssh-sign`; it just can't use them. So if
you're on Bazzite, Bluefin or Aurora and wondering why `~/.1password/agent.sock` never
appears, that's why. No amount of Flatseal fixes it.

[1password-ssh]: https://www.1password.dev/ssh/get-started/

## Layering the RPM works, and I still didn't want to

`rpm-ostree install` would do it. People on Bluefin report the agent, browser
integration and fingerprint unlock all working that way. But layering rebuilds the OS
image locally, slows every update, can block rebases, and Universal Blue's docs call it a
crutch they intend to phase out. My rule on this machine is that anything that modifies
`/usr` client-side is on borrowed time, and the layered list stays at one package. I
wasn't going to spend the second slot on a password manager.

I'd also carried a note from my initial setup research saying the RPM modifies PAM, with
a report of someone locked out after a reinstall. That would have made `usroverlay`
genuinely dangerous, because the overlay makes `/usr` changes transient but not `/etc`
changes. So I read the actual post-install script from the tarball. It writes a polkit
action, a browser allowlist under `/etc/1password`, creates one group and sets setuid on
Electron's `chrome-sandbox`. The string `pam` does not appear. System-auth unlock and CLI
authorization both go through polkit. Whatever locked that person out, it wasn't PAM.

Which meant `usroverlay` was the wrong experiment anyway. It would have tested the RPM,
and the RPM was the option I was trying to avoid.

## Homebrew, via the Universal Blue tap

Homebrew 7 runs Linux casks now, and Universal Blue ships two for 1Password in a [tap][ublue-tap]
Bazzite already has configured:

```bash
brew install --cask ublue-os/tap/1password-gui-linux ublue-os/tap/1password-cli-linux
```

The casks unpack the official tarball into the brew prefix and then do, with `sudo`,
exactly the parts of the upstream post-install script that need root. Everything lands
somewhere that survives an image update, and nothing touches `/usr`:

| What | Where |
|---|---|
| app, `op`, `op-ssh-sign`, browser helper | `/home/linuxbrew/.linuxbrew/Caskroom/…` |
| polkit action for unlock, CLI and agent authorization | `/etc/polkit-1/actions/` |
| browser allowlist | `/etc/1password/custom_allowed_browsers` |
| groups `onepassword` and `onepassword-cli` | `/etc/group` |

I diffed `ostree admin config-diff` before and after. Those are the only changes.

[ublue-tap]: https://github.com/ublue-os/homebrew-tap

## The trap: every privileged cask fails on Bazzite

The install failed twice before it succeeded, and the failure looks like this:

```
Authorization required, but no authorization protocol specified
(gnome-ssh-askpass:234002): Gtk-WARNING **: cannot open display: :0
sudo: no password was provided
sudo: a password is required
The parent process failed to run privileged cask install step 0. (RuntimeError)
```

Three things line up to cause it. Bazzite exports `SUDO_ASKPASS` globally from
`/etc/profile.d/askpass.sh`, pointing at gnome-ssh-askpass. Homebrew treats the mere
presence of that variable as "use `sudo -A`", which forbids prompting on the terminal.
And brew scrubs the environment for its children, keeping `DISPLAY` but dropping
`XAUTHORITY`, so the X11 askpass can't authenticate to Xwayland. Sudo gets nothing and
the cask rolls back. This is filed as [ublue-os/bazzite#5858][askpass-issue] and affects
any cask with a privileged step, not just these two.

The fix is one line:

```bash
unset SUDO_ASKPASS
brew install --cask ublue-os/tap/1password-gui-linux ublue-os/tap/1password-cli-linux
```

With the variable gone, brew falls back to plain `sudo` and prompts on the terminal. The
issue lists `sudo -v` beforehand as a workaround; it did not work for me, and I'd skip
straight to the `unset`. You'll need it again for `brew upgrade` whenever a 1Password cask
has a new version, because the postflight re-applies root ownership.

[askpass-issue]: https://github.com/ublue-os/bazzite/issues/5858

## Turn things on, then check

The brew app keeps its state in `~/.config/1Password`, separate from the Flatpak's, so
you sign in again. Then three settings: **General → Keep 1Password in the system tray**,
or the agent dies with the window; **Security → Unlock using system authentication**,
which is the polkit prompt; **Developer → Integrate with 1Password CLI** and **Use the
SSH agent**.

Verification that convinced me:

```bash
SSH_AUTH_SOCK=~/.1password/agent.sock ssh-add -l   # lists the key
ssh -v -T git@github.com 2>&1 | grep 'Will attempt key'   # ends in "agent", not a file path
op vault list                                       # authorizes through the app
```

Then `flatpak uninstall com.onepassword.OnePassword`, or you'll have two tray icons
fighting over the same extension.

## Browser integration: I declined

If your browser is also a Flatpak, the extension still can't reach the app, and this one
I chose not to fix. The cask writes a native-messaging manifest and a wrapper that calls
`flatpak-spawn --host`. Two problems. Firefox isn't allowed to talk to
`org.freedesktop.Flatpak`, so that call is refused. And within minutes the 1Password app
rewrites the manifest to point straight at the helper binary, which the sandbox can't
see.

The sanctioned answer is a portal, and it isn't shipped yet. The old
`org.freedesktop.portal.WebExtensions` proposal was never accepted. Its replacement,
`xdg-native-messaging-proxy`, has a [Firefox client as of 157][nm-proxy] behind a pref that defaults
off, and Fedora 44 has no package for the service. Until that lands, the only working
route is `flatpak override --user --talk-name=org.freedesktop.Flatpak org.mozilla.firefox`,
which lets anything inside the Firefox sandbox run arbitrary commands on the host as you.
Against a hostile page, that's no sandbox at all. What it buys is not having to unlock
the extension separately from the app. I'd flagged it at setup as something to revisit if it got annoying, and
it hasn't. A browser sandbox weighs more.

[nm-proxy]: https://bugzilla.mozilla.org/show_bug.cgi?id=1955255

## The rule I'd generalize

Every install mechanism on an atomic desktop either lies about the image or it doesn't.
Flatpak, Homebrew, Distrobox and edits under `/etc` all leave `/usr` alone and survive the
coming `bootc` transition. Layering is the one common mechanism that doesn't. When
something isn't available the easy way, the question to ask before reaching for
`rpm-ostree install` is whether someone has already put it in `/var` for you. For
1Password, Universal Blue had.
