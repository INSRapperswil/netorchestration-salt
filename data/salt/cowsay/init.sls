required_packages:
  pkg.installed:
    - pkgs:
      - git
      - perl
      - fortune

cowsay_source:
  git.latest:
    - name: https://github.com/jasonm23/cowsay.git
    - target: /root/cowsay

run_installer:
  cmd.run:
    - name: ./install.sh /usr/local
    - cwd: /root/cowsay
    - onchanges:
      - git: cowsay_source
