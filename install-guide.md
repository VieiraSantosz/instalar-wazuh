<h1 align="center">

[![Wazuh Logo](https://github.com/user-attachments/assets/119abd64-9d52-4170-b976-6037f76f6097)](https://wazuh.com)

Guia de Instalação do Wazuh

</h1>

<h4 align="center">

Instruções para a instalação do Wazuh e o primeiro acesso à plataforma.

</h4>

## Pré-Requisitos

Os pré-requisitos para fazer a instalação do Wazuh são os seguintes:

- **Sistema operacional:** CentOS 7 ou superior, Red Hat Enterprise Linux (RHEL) 7 ou superior, Ubuntu 18.04 ou superior, ou Amazon Linux 2
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
1. Na URL do seu navegador, insira ‎https://localhost para acessar a plataforma.
   
![Wazuh](https://github.com/user-attachments/assets/0c00fa9f-0b92-47a1-83a1-a1bbe5145d31)

2. Com as informações de login e senha fornecidas pelo assistente do Wazuh, insira os dados em cada campo e clique em **Log in** para continuar.

![Wazuh](https://github.com/user-attachments/assets/88f1c874-f404-4094-8000-e29f428a8926)

3. Após o primeiro acesso à aplicação, ela estará pronta para uso.

![image](https://github.com/user-attachments/assets/83deff03-05c0-4a5b-8aea-756dbac1c52e)

   
 


