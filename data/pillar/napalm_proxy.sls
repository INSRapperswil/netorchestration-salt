proxy:
  proxytype: napalm
  host: {{ grains['id'] }}{{ salt['environ.get']('proxy_domain_suffix') }}
  username: {{ salt['environ.get']('napalm_username') }}
  password: {{ salt['environ.get']('napalm_password') }}
