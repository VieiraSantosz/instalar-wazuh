<h1 align="center">

[![Wazuh Logo](https://github.com/user-attachments/assets/119abd64-9d52-4170-b976-6037f76f6097)](https://wazuh.com)

Guia de Instalação do Wazuh

</h1>

<h4 align="center">

Instruções para a instalação do Wazuh e o primeiro acesso à plataforma.

</h4>

## Pré-Requisitos

Os pré-requisitos para fazer a instalação do Wazuh são os seguintes:

- **Sistema operacional:** CentOS, Red Hat, Ubuntu e Amazon Linux
- **Mínimo de memória RAM:** 8 GB
- **Mínimo recomendado de CPU:** 4 CPU

## Instalação do Wazuh

1. Atualizar seu servidor:
```bash
sudo apt update && sudo apt upgrade -y
```

2. Baixar e executar o assistente de instalação do Wazuh:
```bash
curl -sO https://packages.wazuh.com/4.10/wazuh-install.sh && sudo bash ./wazuh-install.sh -a
```

Finalizado a instalação, o próprio assistente de instalação do Wazuh irá informar o seu login e senha de acesso
![Acesso Wazuh](https://github.com/user-attachments/assets/f97a4b13-0ef6-4945-9eaa-a8e0452bb383)



