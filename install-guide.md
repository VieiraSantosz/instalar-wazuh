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

1. Atualizar seu servidor.
```bash
sudo apt update && sudo apt upgrade -y
```

2. Baixar e executar o assistente de instalação do Wazuh.
```bash
curl -sO https://packages.wazuh.com/4.11/wazuh-install.sh && sudo bash ./wazuh-install.sh -a
```

Após a conclusão da instalação, o assistente do Wazuh fornecerá automaticamente seu login e senha de acesso.
![Acesso Wazuh](https://github.com/user-attachments/assets/3297659a-f968-499d-af37-ce7f5d7a0eb4)


## Primeiro acesso à plataforma
1. Na URL do seu navegador, insira ‎https://localhost
   
![Wazuh](https://github.com/user-attachments/assets/f5886fc3-3eab-4627-b4c4-0b2c32e33cdc)

   
 


