<h1 align="center">

[![Wazuh Logo](https://github.com/user-attachments/assets/119abd64-9d52-4170-b976-6037f76f6097)](https://wazuh.com)

Guia de Instalação do Wazuh

</h1>

<h4 align="center">

Instruções para a instalação do Wazuh e o primeiro acesso à plataforma.

</h4>

## Pré-Requisitos

Os pré-requisitos para fazer a instalação do Wazuh são os seguintes:

- **Sistema operacional:** CentOS, Red Hat Enterprise Linux (RHEL), Ubuntu, Amazon Linux
- **Mínimo de memória RAM:** 8 GB
- **Mínimo recomendado de CPU:** 4 CPU


## Instalação do Wazuh

**1. Atualizar o servidor:**

Antes de iniciar a instalação, certifique-se de que o sistema está atualizado. Isso garante que os pacotes necessários sejam instalados corretamente.
```bash
sudo apt update && sudo apt upgrade -y
```

**2. Baixar e executar o assistente de instalação do Wazuh;**
```bash
curl -sO https://packages.wazuh.com/4.11/wazuh-install.sh && sudo bash ./wazuh-install.sh -a
```
Este script automatiza a instalação e configuração do Wazuh. Durante o processo, o assistente irá configurar o servidor Wazuh, baixar pacotes necessários e configurar o ambiente para você.

Após a instalação, o assistente do Wazuh fornecerá as credenciais para o primeiro acesso (login e senha). Guarde essas informações, pois você precisará delas para acessar a interface web do Wazuh.

![Acesso Wazuh](https://github.com/user-attachments/assets/3297659a-f968-499d-af37-ce7f5d7a0eb4)


## Primeiro acesso à plataforma
1. Acessar a interface web
```bash
https://localhost
```
**Nota:** Caso você esteja acessando a plataforma remotamente, substitua o **localhost** pelo endereço IP ou nome de domínio do servidor onde o Wazuh foi instalado.

2. Login inicial
Utilize as credenciais fornecidas durante a instalação para realizar o login na plataforma.

![Wazuh](https://github.com/user-attachments/assets/88f1c874-f404-4094-8000-e29f428a8926)

4. Após o primeiro acesso à aplicação, ela estará pronta para uso.

![image](https://github.com/user-attachments/assets/83deff03-05c0-4a5b-8aea-756dbac1c52e)

   
 


