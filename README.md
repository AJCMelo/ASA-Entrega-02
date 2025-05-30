# ASA-Entrega-02

O objetivo desta atividade é preparar uma infraestrutura com Docker Compose contendo, no mínimo:

1. Um servidor de DNS com uma zona primária
2. Um servidor proxy reverso HTTP
3. Dois servidores web com páginas personalizadas

---

## 🗂️ Estrutura do Projeto
```plaintext
ASA-Entrega-02/
│
├─ compose.yaml            # Arquivo de definição do Docker Compose
│
├─ dns/                    # Contêiner de DNS (BIND)
│  ├─ Dockerfile           # Dockerfile para o servidor de DNS
│  ├─ named.conf.local     # Configuração da zona no BIND
│  └─ db.asa.br            # Arquivo de zona primária
│
├─ proxy/                  # Contêiner de proxy reverso (Nginx)
│  ├─ Dockerfile           # Dockerfile para o proxy reverso
│  └─ default.conf         # Configuração do Nginx
│
├─ web01/                  # Primeiro servidor web (Ubuntu)
│  ├─ Dockerfile           # Dockerfile para o servidor web 01
│  └─ index.html           # Página HTML personalizada
│
├─ web02/                  # Segundo servidor web (Debian)
│  ├─ Dockerfile           # Dockerfile para o servidor web 02
│  └─ index.html           # Página HTML personalizada
│
└─ README.md               # Documentação deste projeto
```

🖥️ **Tecnologias Usadas** 🌿  
- Docker  
- Docker Compose  
- BIND (DNS)  
- Nginx (Proxy Reverso)  
- Ubuntu / Debian  
