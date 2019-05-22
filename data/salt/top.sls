base:
  'minion*':
    - cowsay
  'sw0[1-4]-pod-[0-9]':
    - net_example.ntp
    - net_example.syslog
  'os:ios':
    - match: grain
    - net_example.ntp
