# netorchestration-salt

Docker compose will start 2 linux minions and 4 napalm proxies for network devices.
In our lab we have pod's of 4 Cisco Catalyst switches but you can easily adopt it to your setup.

## Settings

In the file `.env` you can set the eviroment variables used in the docker-compose file and inside of the salt master container. For example if you set `hostname_suffix` to `-pod-1` and the `proxy_domain_suffix` to `.lab.ins.hsr.ch`, a proxy minion with the id `sw01` will connect to the network address with the host address `sw01-pod-1.lab.ins.hsr.ch` using the given username and password from the `.env` file.

The idea of the two linux minions is to demonstrate the basic salt concepts.

## Setup

start containers

```bash
docker-compose up -d
```

Accept keys. It can take some seconds until you see the keys and the keys are not persistent.

```bash
docker-compose exec salt sh
/ $ salt-key -L
Accepted Keys:
Denied Keys:
Unaccepted Keys:
minion1
minion2
sw01-pod-X
sw02-pod-X
sw03-pod-X
sw04-pod-X
Rejected Keys:
/ $ salt-key -A
The following keys are going to be accepted:
Unaccepted Keys:
minion1
minion2
sw01-pod-X
sw02-pod-X
sw03-pod-X
sw04-pod-X
Proceed? [n/Y] y
Key for minion minion1 accepted.
Key for minion minion2 accepted.
Key for minion sw01-pod-X accepted.
Key for minion sw02-pod-X accepted.
Key for minion sw03-pod-X accepted.
Key for minion sw04-pod-X accepted.
```

## Demo

Test

```bash
salt minion1 test.ping
minion1:
    True
/ $ salt "sw0[1-3]*" test.ping
sw03-pod-X:
    True
sw02-pod-X:
    True
sw01-pod-X:
    True
```

Install fortune on test minion

```bash
/ $ salt minion1 pkg.install fortune
minion1:
    ----------
    fortune:
        ----------
        new:
            0.1-r0
        old:
    libbsd:
        ----------
        new:
            0.8.6-r2
        old:
```

```bash
/ $ salt minion1 cmd.run fortune
minion1:
    "I like work ... I can sit and watch it for hours."
```

Apply state

```bash
/ $ salt minion1 state.apply cowsay
minion1:
----------
          ID: required_packages
    Function: pkg.installed
      Result: True
     Comment: The following packages were installed/updated: git
              The following packages were already installed: perl, fortune
     Started: 14:34:37.737373
    Duration: 7413.964 ms
     Changes:   
              ----------
              ca-certificates:
                  ----------
                  new:
                      20190108-r0
                  old:
              git:
                  ----------
                  new:
                      2.20.1-r0
                  old:
              libcurl:
                  ----------
                  new:
                      7.64.0-r1
                  old:
              libssh2:
                  ----------
                  new:
                      1.8.2-r0
                  old:
              nghttp2-libs:
                  ----------
                  new:
                      1.35.1-r0
                  old:
              pcre2:
                  ----------
                  new:
                      10.32-r1
                  old:
----------
          ID: cowsay_source
    Function: git.latest
        Name: https://github.com/jasonm23/cowsay.git
      Result: True
     Comment: https://github.com/jasonm23/cowsay.git cloned to /root/cowsay
     Started: 14:34:45.197822
    Duration: 1634.318 ms
     Changes:   
              ----------
              new:
                  https://github.com/jasonm23/cowsay.git => /root/cowsay
              revision:
                  ----------
                  new:
                      b67eda47925e8dee3a3fd4b513127a3f4ae15341
                  old:
                      None
----------
          ID: run_installer
    Function: cmd.run
        Name: ./install.sh /usr/local
      Result: True
     Comment: Command "./install.sh /usr/local" run
     Started: 14:34:46.834647
    Duration: 40.86 ms
     Changes:   
              ----------
              pid:
                  528
              retcode:
                  0
              stderr:
                  + mkdir -p /usr/local/bin
                  + /usr/bin/perl -p install.pl cowsay
                  + chmod a+x /usr/local/bin/cowsay
                  + ln -s cowsay /usr/local/bin/cowthink
                  ln: /usr/local/bin/cowthink: File exists
                  + mkdir -p /usr/local/man/man1
                  + /usr/bin/perl -p install.pl cowsay.1
                  + chmod a+r /usr/local/man/man1/cowsay.1
                  + ln -s cowsay.1 /usr/local/man/man1/cowthink.1
                  ln: /usr/local/man/man1/cowthink.1: File exists
                  + mkdir -p /usr/local/share/cows
                  + tar -cf - cows+ 
                  cd /usr/local/share
                  + tar -xvf -
                  + set +x
              stdout:
                  ===================
                  cowsay Installation
                  ===================
                  
                  Searching for useful perl executables...
                  Found perl in /usr/bin/perl
                  Found perl in /usr/bin/perl5.26.3
                  Found a good perl in /usr/bin/perl
                  Found a good perl in /usr/bin/perl5.26.3
                  The following perl executables will run cowsay:
                  /usr/bin/perl /usr/bin/perl5.26.3
                  I recommend the latest stable perl you can find.
                  I will be using /usr/bin/perl because I know it will work.
                  Now I need an installation prefix. I will use /usr/local unless
                  you give me a better idea here: /usr/local (specified on command line)
                  Okay, time to install this puppy.
                  cows/
                  cows/dragon-and-cow.cow
                  cows/vader-koala.cow
                  cows/cower.cow
                  cows/kitty.cow
                  cows/kosh.cow
                  cows/vader.cow
                  cows/bud-frogs.cow
                  cows/turkey.cow
                  cows/hellokitty.cow
                  cows/squirrel.cow
                  cows/daemon.cow
                  cows/www.cow
                  cows/telebears.cow
                  cows/dragon.cow
                  cows/surgery.cow
                  cows/sodomized.cow
                  cows/ghostbusters.cow
                  cows/mutilated.cow
                  cows/default.cow
                  cows/cheese.cow
                  cows/beavis.zen.cow
                  cows/flaming-sheep.cow
                  cows/mech-and-cow
                  cows/koala.cow
                  cows/bunny.cow
                  cows/small.cow
                  cows/elephant.cow
                  cows/milk.cow
                  cows/supermilker.cow
                  cows/sheep.cow
                  cows/stimpy.cow
                  cows/satanic.cow
                  cows/bong.cow
                  cows/turtle.cow
                  cows/udder.cow
                  cows/elephant-in-snake.cow
                  cows/stegosaurus.cow
                  cows/moose.cow
                  cows/moofasa.cow
                  cows/ren.cow
                  cows/kiss.cow
                  cows/eyes.cow
                  cows/tux.cow
                  cows/three-eyes.cow
                  cows/head-in.cow
                  cows/skeleton.cow
                  cows/luke-koala.cow
                  cows/meow.cow
                  Okay, let us see if the install actually worked.
                  Installation complete! Enjoy the cows!
Summary for minion1
------------
Succeeded: 3 (changed=3)
Failed:    0
------------
Total states run:     3
Total run time:   9.089 s
```

Don't install if nothing changes

```bash
/ $ salt minion1 state.apply cowsay
minion1:
----------
          ID: required_packages
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 14:35:57.567411
    Duration: 232.491 ms
     Changes:   
----------
          ID: cowsay_source
    Function: git.latest
        Name: https://github.com/jasonm23/cowsay.git
      Result: True
     Comment: Repository /root/cowsay is up-to-date
     Started: 14:35:57.808658
    Duration: 1146.242 ms
     Changes:   
----------
          ID: run_installer
    Function: cmd.run
        Name: ./install.sh /usr/local
      Result: True
     Comment: State was not run because none of the onchanges reqs changed
     Started: 14:35:58.962433
    Duration: 0.016 ms
     Changes:   
Summary for minion1
------------
Succeeded: 3
Failed:    0
------------
Total states run:     3
Total run time:   1.379 s
```

Use the awesome cowsay

```console
/ $ salt minion1 cmd.run "fortune | cowsay"
minion1:
     ___________________________________ 
    / Pohl's law:                       \
    |                                   |
    | Nothing is so good that somebody, |
    \ somewhere, will not hate it.      /
     ----------------------------------- 
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||
```

Renderes state file demo:

```bash
/ $ salt minion1 state.apply cowsay.jinja_test
```

Highstate

```bash
/ $ salt 'sw*' state.highstate
sw01-pod-X:
----------
          ID: netntp_example
    Function: netntp.managed
      Result: True
     Comment: 
     Started: 16:55:46.050655
    Duration: 14992.631 ms
     Changes:   
              ----------
              servers:
                  ----------
                  added:
                      - 0.ch.pool.ntp.org
                      - 1.ch.pool.ntp.org
                  removed:
                      - 130.60.204.10
----------
          ID: syslog_example
    Function: netconfig.managed
      Result: True
     Comment: Configuration changed!
     Started: 16:56:01.044423
    Duration: 11787.94 ms
     Changes:   
              ----------
              diff:
                  +logging host 152.96.11.5 vrf Mgmt-vrf
              loaded_config:
                  
                  logging host 152.96.11.5 vrf Mgmt-vrf
Summary for sw01-pod-X
------------
Succeeded: 2 (changed=2)
Failed:    0
------------
Total states run:     2
Total run time:  26.781 s
sw02-pod-X:
----------
          ID: netntp_example
    Function: netntp.managed
      Result: True
     Comment: 
     Started: 16:55:45.801834
    Duration: 15202.234 ms
     Changes:   
              ----------
              servers:
                  ----------
                  added:
                      - 0.ch.pool.ntp.org
                      - 1.ch.pool.ntp.org
                  removed:
                      - 130.60.204.10
----------
          ID: syslog_example
    Function: netconfig.managed
      Result: True
     Comment: Configuration changed!
     Started: 16:56:01.008104
    Duration: 12028.22 ms
     Changes:   
              ----------
              diff:
                  +logging host 152.96.11.5 vrf Mgmt-vrf
              loaded_config:
                  
                  logging host 152.96.11.5 vrf Mgmt-vrf
Summary for sw02-pod-X
------------
Succeeded: 2 (changed=2)
Failed:    0
------------
Total states run:     2
Total run time:  27.230 s
sw03-pod-X:
----------
          ID: netntp_example
    Function: netntp.managed
      Result: True
     Comment: 
     Started: 16:55:45.938761
    Duration: 15620.274 ms
     Changes:   
              ----------
              servers:
                  ----------
                  added:
                      - 0.ch.pool.ntp.org
                      - 1.ch.pool.ntp.org
                  removed:
                      - 130.60.204.10
----------
          ID: syslog_example
    Function: netconfig.managed
      Result: True
     Comment: Configuration changed!
     Started: 16:56:01.560149
    Duration: 11728.821 ms
     Changes:   
              ----------
              diff:
                  +logging host 152.96.11.5 vrf Mgmt-vrf
              loaded_config:
                  
                  logging host 152.96.11.5 vrf Mgmt-vrf
Summary for sw03-pod-X
------------
Succeeded: 2 (changed=2)
Failed:    0
------------
Total states run:     2
Total run time:  27.349 s
sw04-pod-X:
----------
          ID: netntp_example
    Function: netntp.managed
      Result: True
     Comment: 
     Started: 16:55:45.774672
    Duration: 15590.344 ms
     Changes:   
              ----------
              servers:
                  ----------
                  added:
                      - 0.ch.pool.ntp.org
                      - 1.ch.pool.ntp.org
                  removed:
                      - 130.60.204.10
----------
          ID: syslog_example
    Function: netconfig.managed
      Result: True
     Comment: Configuration changed!
     Started: 16:56:01.366856
    Duration: 12475.448 ms
     Changes:   
              ----------
              diff:
                  +logging host 152.96.11.5 vrf Mgmt-vrf
              loaded_config:
                  
                  logging host 152.96.11.5 vrf Mgmt-vrf
Summary for sw04-pod-X
------------
Succeeded: 2 (changed=2)
Failed:    0
------------
Total states run:     2
Total run time:  28.066 s
```
