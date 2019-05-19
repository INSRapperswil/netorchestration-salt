syslog_example:
  netconfig.managed:
    - template_name: salt://net_example/syslog_{{ grains['os'] }}.j2
    - debug: True
    - servers:
      - 152.96.11.6
