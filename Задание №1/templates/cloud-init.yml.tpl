users:
  - name: yc-user
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    shell: /bin/bash
    ssh-authorized-keys:
      %{ for key in ssh_keys ~}
      - "${key}"
      %{ endfor ~}

runcmd:
  - [ sh, -c, "apt update -y" ]
  - [ sh, -c, "apt install -y nginx" ]
  - [ sh, c, "systemctl enable nginx" ]
