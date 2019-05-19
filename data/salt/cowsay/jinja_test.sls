{% set cowfiles = salt.cmd.run('cowsay -l').split('\n')[1:] %}
{% set ascii_arts = cowfiles | join(' ') %}

{% for ascii_art in ascii_arts.split(' ') %}
run_cowsay_{{ ascii_art }}: # name must be unique
  cmd.run:
    {% if ascii_art is in ['head-in', 'sodomized', 'telebears'] %}
    - name: echo cowsay -f {{ ascii_art }} should not be used
    {% else %}
    - name: fortune | cowsay -f {{ ascii_art }}
    {% endif %}
{% endfor %}
