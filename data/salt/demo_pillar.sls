echo_pillar_demo_1:
  cmd.run:
    - name: "echo {{ pillar.demo_text | default('pillar not defined') }}"

echo_pillar_demo_2:
  cmd.run:
    - name: "echo {{ pillar.demo.text | default('pillar not defined') }}"
