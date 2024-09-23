FROM linuxserver/code-server:latest

# Docker
RUN apt-get update && \
    apt-get install -y ca-certificates curl && \
    mkdir -p /etc/apt/keyrings.d && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Node
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global prettier

# Python
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN apt-get update && \
    apt-get install -y python3-pip && \
    echo 'export PATH="$PATH:/config/.local/bin"' >> ~/.bashrc && \
    pip install pytest pyinstaller

# PostgreSQL
RUN apt-get update && \
    apt-get install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring && \
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /usr/share/keyrings/postgresql-archive-keyring.gpg >/dev/null && \
    sh -c 'echo "deb [signed-by=/usr/share/keyrings/postgresql-archive-keyring.gpg] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    apt-get update && \
    apt-get install -y postgresql-16 postgresql-client-16

# Окружение
RUN echo 'prun() { if [ "$#" -eq 0 ]; then python3 main.py; elif [ -f "$1" ]; then python3 "$1"; elif [ -f "$1.py" ]; then python3 "$1.py"; else echo "Файл не найден"; fi; }\n\
    pybuild() { filename=$1; [[ ! "$filename" == *.py ]] && filename="$filename.py"; pyinstaller --onefile --distpath . "$filename" && rm -R build "$filename.spec"; }' >> /etc/bash.bashrc && \
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Библиотеки
RUN pip install psycopg2-binary beautifulsoup4 telethon redis textual