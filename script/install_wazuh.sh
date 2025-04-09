# !/bin/bash
#
# wazuh.sh - faz a instalação da ferramenta Wazuh
#
# Autor..: Wesley Santos  <wesleyv760@gmail.com>
# Auxílio: Daniel Brandão <>
#
# -------------------------------------------------------------------------------------
#
# Este programa faz a instalação da ferramenta Wazuh (SIEM), 
# retornando o seu link de acesso, usuário e senha. 
#


# Função para exibir a barra de progresso sincronizada com a execução real do comando
progress_bar() {
    local cmd="$1"      # Comando a ser executado passado como argumento
    local log_file="$2" # Nome do arquivo onde será armazenada a saída do comando

    rm -f "$log_file" # Remove o arquivo de log anterior, caso exista
    touch "$log_file" # Cria um novo arquivo vazio para armazenar a saída do comando

    # Executa o comando fornecido em segundo plano, redirecionando sua saída para o arquivo de log
    eval "$cmd" >"$log_file" 2>&1 &
    local cmd_pid=$!  # Captura o PID (identificador do processo) do comando em execução

    local total_lines=100     # Define um valor estimado de total de linhas processadas para calcular a barra de progresso
    local current_line=0      # Inicializa a variável que irá contar as linhas processadas no log
    local elapsed_time=0      # Tempo decorrido desde o início da execução do comando
    local max_time=180        # Tempo máximo (em segundos) antes de começar a exibir avisos (3 minutos)
    local warned=0            # Contador de quantos avisos já foram emitidos
    local warning_limit=5     # Limite máximo de avisos para o usuário
    local last_warning_time=0 # Registra o tempo do último aviso exibido

    # Loop que verifica continuamente se o processo ainda está rodando
    while kill -0 $cmd_pid 2>/dev/null; do

        # Conta o número de linhas geradas no arquivo de log até o momento
        current_line=$(wc -l < "$log_file")  
        
        # Calcula a porcentagem de progresso baseado no número de linhas geradas
        local progress=$((current_line * 100 / total_lines))

        # Garante que o progresso não ultrapasse 98% (para evitar uma finalização prematura)
        if [ $progress -gt 98 ]; then progress=98; fi  

        # Calcula quantos caracteres preencher na barra de progresso
        local filled=$((progress / 2)) # A cada 2% um ponto será preenchido
        local empty=$((50 - filled))   # Espaços vazios restantes para completar a barra

        # Exibe a barra de progresso no terminal
        printf "\r["                    # Retorna ao início da linha para sobreescrever a barra de progresso anterior
        printf "%0.s." $(seq 1 $filled) # Imprime os pontos correspondentes ao progresso
        printf "%0.s " $(seq 1 $empty)  # Imprime os espaços restantes
        printf "] %d%%" "$progress"     # Exibe a porcentagem de progresso
        sleep 0.5                       # Aguarda meio segundo antes da próxima atualização

        ((elapsed_time++)) # Incrementa o tempo decorrido

        # Verifica se o tempo máximo foi atingido e controla a exibição de avisos
        if ((elapsed_time >= max_time)); then

            if ((warned < warning_limit)); then
                local current_time=$(date +%s) # Obtém o tempo atual em segundos

                if ((current_time - last_warning_time >= 180)); then  # Se já passaram 3 minutos desde o último aviso
                    printf "\n\nO processo está demorando mais que o esperado. Aguarde...\n\n"

                    last_warning_time=$current_time # Atualiza o tempo do último aviso
                    ((warned++))                    # Incrementa o contador de avisos
                fi
            fi
        fi
    done

    # Quando o processo termina, exibe a barra de progresso completa
    printf "\r[..................................................] 100%% concluído\n"
}


# Função para verificar se o script está sendo executado como root
root () {
    if [ "$(id -u)" != 0 ]; then
        clear
        echo -e "\n🚫 Atenção!!!"
        echo -e "\nPara o funcionamento desse script, necessário executar com o usuário administrador (root).\n\n"
        exit 1
    fi    
}


# Função para obter o IP da máquina
get_ip () {
    IP_LOCAL=$(hostname -I | awk '{print $1}')
}


# Função para escrever o banner no início da instalação
banner () {
    clear
    echo "

     /##      /##                               /##      
    | ##  /# | ##                              | ##      
    | ## /###| ##  /######  /######## /##   /##| ## 
    | ##/## ## ## |____  ##|____ /##/| ##  | ##| #######
    | ####_  ####  /#######   /####/ | ##  | ##| ##__  ##
    | ###/ \  ### /##__  ##  /##__/  | ##  | ##| ##  \ ##
    | ##/   \  ##|  ####### /########|  ######/| ##  | ##
    |__/     \__/ \_______/|________/ \______/ |__/  |__/
    
                                        𝑀𝒶𝒹𝑒 𝐵𝓎: 𝒲 𝑒𝓈𝓁𝑒𝓎 𝒮𝒶𝓃𝓉𝑜𝓈"
}


# Função para verificar os requisitos mínimos do Sistema Operacional
check_system_minimum () {
    echo ""

    # Verifica a distribuição do sistema operacional 
    source /etc/os-release
    OS_NAME=$ID
    VERIFY_OS=false

    sleep 1.5
    if [ "$OS_NAME" == "ubuntu" ]; then
        VERIFY_OS=true
        echo "✅ Sistema Operacional..........: $OS_NAME"
    else 
        echo "❌ Sistema Operacional..........: $OS_NAME"
    fi


    # Verifica a versão do sistema operacional 
    VALID_VERSIONS=("16.04" "18.04" "20.04" "22.04" "24.04")
    OS_VERSION=$(lsb_release -rs)
    VERIFY_VERSION=false

    sleep 1.5
    for version in "${VALID_VERSIONS[@]}"; do
        if [ "$OS_VERSION" == "$version" ]; then
            VERIFY_VERSION=true
            break
        fi
    done

    if [ "$VERIFY_VERSION" == "true" ]; then
        echo "✅ Versão do Sistema Operacional: $OS_VERSION"
    else
        echo "❌ Versão do Sistema Operacional: $OS_VERSION"
    fi


    # Verifica a quantidade de núcleos do sistema operacional  
    CPU_MIN=4 
    CPU_COUNT=$(nproc)
    VERIFY_CPU=false

    sleep 1.5
    if [ "$CPU_COUNT" -ge "$CPU_MIN" ]; then
        VERIFY_CPU=true
        echo "✅ CPU..........................: $CPU_COUNT núcleos"        
    else 
        echo "❌ CPU..........................: $CPU_COUNT núcleos"
    fi


    # Verifica a quantidade de RAM do sistema operacional  
    RAM_MIN=8
    RAM_TOTAL=$(free -g | awk '/Mem:/ {print $2}')
    VERIFY_RAM=false

    sleep 1.5
    if [ "$RAM_TOTAL" -ge "$RAM_MIN" ]; then
        VERIFY_RAM=true
        echo "✅ RAM..........................: $RAM_TOTAL GB"
    else 
        echo "❌ RAM..........................: $RAM_TOTAL GB"
    fi


    # Verifica a quantidade de DISCO do sistema operacional  
    DISK_MIN=50
    DISK_AVAILABLE=$(df --output=avail -BG / | tail -1 | awk '{print substr($1, 1, length($1)-1)}')
    VERIFY_DISK=false

    sleep 1.5
    if [ "$DISK_AVAILABLE" -ge "$DISK_MIN" ]; then
        VERIFY_DISK=true
        echo "✅ DISCO........................: $DISK_AVAILABLE GB"
    else 
        echo "❌ DISCO........................: $DISK_AVAILABLE GB"
    fi


    # Informa os requisitos mínimos necessários para instalação 
    sleep 1.5 
    if [ "$VERIFY_OS" = "false" ] || [ "$VERIFY_VERSION" = "false" ] || [ "$VERIFY_CPU" = "false" ] || [ "$VERIFY_RAM" = "false" ] || [ "$VERIFY_DISK" = "false" ]; then
        echo -e "\n\nSeu sistema operacional não possui os requisitos mínimos necessários para instalação."
        echo -e "\n\nOs requisitos mínimos são os seguintes:\n"
        echo "Distribuição do Sistema Operacional: Ubuntu"
        echo "Versão do Sistema Operacional......: ${VALID_VERSIONS[*]}"
        echo "CPU................................: $CPU_MIN núcleos"
        echo "RAM................................: $RAM_MIN GB"
        echo "Disco Disponível...................: $DISK_MIN GB"
        echo -e "\n\n--------------------------------------------------------------------------------\n\n"
        exit 1

    else
        echo -e "\n\nSeu sistema operacional possui todos os requisitos mínimos necessários para instalação."
        echo -e "\nSua instalação irá começar em:\n"
        
        for i in $(seq 5 -1 1); do
            echo "$i"
            sleep 1
        done
        sleep 1
    fi
}


# Função para verificar se existem algum serviço do Wazuh (SIEM)
wazuh_services () {

    # Busca por serviços do Wazuh (SIEM)
    SERVICES=$(systemctl list-units --type=service --no-pager | grep "wazuh-" | awk '{print $1}')

    # Verifica se encontrou algum serviço do Wazuh (SIEM)
    if [ -n "$SERVICES" ]; then
        echo -e "\n\n⚠️ Foram encontrados serviços do Wazuh (SIEM) ativo na sua máquina."
        echo -e "\nDeseja seguir com a instalação?"
        echo -e "OBS: O instalador irá remover o Wazuh existente e instalar um novo."
        echo -e "\n(1) Seguir com a instalação"
        echo "(2) Não realizar a instalação"

        # Captura a escolha do usuário
        echo ""
        read -p "Escolha uma opção (1 ou 2): " OPC

        if [ "$OPC" == "1" ]; then
            echo -e "\n\nRemovendo Wazuh (SIEM) existente"
            wazuh_remove

            echo -e "\n\nInstalando e configurando o novo Wazuh (SIEM)"
            wazuh_packages

        elif [ "$OPC" == "2" ]; then
            echo -e "\n\nNão foi realizada a instalação do Wazuh (SIEM)"
            echo -e "\n\n-----------------------------------------------------------------------\n\n"
            exit 1
        
        else
            echo -e "\n\n🚫 Por favor, selecione uma opção válida!!!"
            wazuh_services
        fi

    else

        echo -e "\n\nInstalando e configurando o Wazuh (SIEM)"
        wazuh_packages
    fi
}


# Função para remover/desisntalar o Wazuh (SIEM)
wazuh_remove () {
    path_wzh=$(sudo find / -name "wazuh-install-files.tar" 2>/dev/null | rev | cut -d'/' -f2- | rev)
    cd $path_wzh 2>/dev/null

    progress_bar "curl -sO https://packages.wazuh.com/4.11/wazuh-install.sh && sudo bash ./wazuh-install.sh -u" "/tmp/wazuh_install_log"
    sleep 1
    
    sudo rm -rf wazuh-* 2>/dev/null
    sudo rm -rf $path_wzh 2>/dev/null
}


# Função para criar o diretório da ferramenta
wazuh_diretory () {
    mkdir /siem_wazuh 2>/dev/null
    cd /siem_wazuh
}


# Função para instalar os pacotes do Wazuh (SIEM)
wazuh_packages () {
    wazuh_diretory
    progress_bar "curl -sO https://packages.wazuh.com/4.11/wazuh-install.sh && sudo bash ./wazuh-install.sh -a" "/tmp/wazuh_install_log"
}


# Função para mostrar os acessos do Wazuh (SIEM)
wazuh_acess () {
    path_wzh=$(sudo find / -name "wazuh-install-files.tar" 2>/dev/null | rev | cut -d'/' -f2- | rev)
    cd $path_wzh

    user=$(tar -axf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt -O | grep "indexer_username" | head -n 1 | cut -d"'" -f2)
    password=$(tar -axf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt -O | grep "indexer_password" | head -n 1 | cut -d"'" -f2)

    get_ip

    echo -e "\n\nAcesso ao Wazuh (SIEM):"
    echo -e "\nLink de acesso: https://${IP_LOCAL}"
    echo -e "User..........: $user"
    echo -e "Senha.........: $password"
}


#################################################################################################################################


### Parte 1 - Validar se o Sistema Operacional atende os requisitos mínimos necessários

root
banner

echo -e "\n\n----- Verificando se seu Sistema Operacional atende os requisitos mínimos ------"
check_system_minimum
echo -e "\n\n--------------------------------------------------------------------------------"

############################################################


### Parte 2 - Executar o assistente de instalação do Wazuh (SIEM)

banner

echo -e "\n\n------ 1. Executando o assistente de instalação do Wazuh (SIEM) -------"
sleep 2
wazuh_services
echo -e "\n\n---------------- Instalação do Wazuh (SIEM) finalizada ----------------"

############################################################


### Parte 3 - Acesso ao servidor Wazuh (SIEM)
echo -e "\n\n\n\n\n--------------------------- Acesso ao Wazuh ---------------------------"
sleep 2
wazuh_acess
echo -e "\n\nArquivos de instalação do Wazuh estão localizados dentro do diretório raiz em: /siem_wazuh"

echo -e "\n\n-----------------------------------------------------------------------\n\n"

############################################################