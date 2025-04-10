<h1 align="center">

[![Wazuh Logo](https://github.com/user-attachments/assets/119abd64-9d52-4170-b976-6037f76f6097)](https://wazuh.com)

Script para Instalação do Wazuh

</h1>

<h4 align="center">

Instruções para executar o script install_wazuh.sh e o primeiro acesso à plataforma. 

</h4>

## Pré-Requisitos

Antes de executar o script, verifique se o seu servidor atende aos seguintes requisitos:

- **Sistema operacional:** CentOS, Red Hat Enterprise Linux (RHEL), Ubuntu e Amazon Linux
- **Mínimo de disco:** 50 GB
- **Mínimo de memória RAM:** 8 GB
- **Mínimo de CPU:** 4 CPU


## Execução do Script
1. Clone o repositório
```bash
git clone https://github.com/VieiraSantosz/wazuh-guide.git
```

2. Acesse a pasta do onde está localizado o script
```bash
cd /wazuh-guide/script
```

3. Mudar a permissão do Script para pode ser executar
```bash
chmod +x install_wazuh.sh
```
4. Executar o Script
```bash
./install_wazuh.sh
```

Após a instalação, o script fornecerá as credenciais para o primeiro acesso (login e senha) e o link da interface web. Guarde essas informações, pois você precisará delas para acessar a plataforma do Wazuh.


## Primeiro acesso à plataforma
**1. Acessar a interface web**

Após a instalação, abra o seu navegador e insira a seguinte URL para acessar a plataforma do Wazuh:
```bash
https://localhost
```
**Nota:** Caso você esteja acessando a plataforma remotamente, substitua o **localhost** pelo endereço IP ou nome de domínio do servidor onde o Wazuh foi instalado.

**2. Login inicial**

Utilize as credenciais fornecidas durante a instalação para realizar o login na plataforma.

![Wazuh](https://github.com/user-attachments/assets/88f1c874-f404-4094-8000-e29f428a8926)

**3. Após o Login**

Depois de realizar o login, você estará pronto para começar a explorar e configurar a plataforma Wazuh.

![image](https://github.com/user-attachments/assets/83deff03-05c0-4a5b-8aea-756dbac1c52e)
















