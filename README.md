# Executando um Contêiner Docker com GPU

Este guia fornece instruções sobre como executar um contêiner Docker utilizando a imagem `nvidia/cuda:12.0.1-devel-ubuntu20.04` com suporte a GPU. O contêiner será configurado com variáveis de ambiente e montará um volume local.

## Pré-requisitos

Antes de executar o comando, você deve ter o seguinte:

1. **Docker** instalado e em funcionamento no seu sistema.
2. **NVIDIA Docker** configurado corretamente para suportar GPUs.
3. Um arquivo `init.sh` na sua pasta atual que contém os comandos a serem executados dentro do contêiner.

## Executando o Comando

Para executar o comando:

1. Abra o terminal.
2. Navegue até o diretório onde o arquivo `init.sh` está localizado.
3. Execute o comando abaixo:

```bash
docker run --gpus all \
  -e GPU_NAME=67 \
  -e GPU_SIZE=100000000000 \
  -e GPU_ADDRESS=local \
  -e GPU_BLOCKS=3000 \
  -v "$(pwd):/home" \
  -it nvidia/cuda:12.0.1-devel-ubuntu20.04 \
  /bin/bash -c "sed -i 's/\r$//' /home/init.sh && /bin/bash /home/init.sh"
