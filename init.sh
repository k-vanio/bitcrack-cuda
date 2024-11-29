#!/bin/bash
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install htop nano git -y

# Cloning BitCrack repository...
echo "Cloning BitCrack repository..."
git clone https://github.com/k-vanio/BitCrack.git

# Enter the BitCrack directory
cd BitCrack

# Compile BitCrack with CUDA support
echo "Compile BitCrack with CUDA support"
make BUILD_CUDA=1

# Verify that the compilation was successful
if [ $? -ne 0 ]; then
    echo "Erro ao compilar o BitCrack."
    exit 1
fi

# Moving files
echo "Moving files from bin folder to /usr/local/bin..."
mv bin/* /usr/local/bin/

# Verifica se NAME está definido, caso contrário, exibe um erro e encerra
if [ -z "$GPU_NAME" ]; then
  echo "Error: NAME is required."
  exit 1
fi

# Define valores padrão para as variáveis se não estiverem definidas
GPU_SIZE=${GPU_SIZE:-25000000000}

GPU_ADDRESS=${GPU_ADDRESS:-RTX-4090}

GPU_BLOCKS=${GPU_BLOCKS:-2000}

GPU_PING=${GPU_PING:-1}

GPU_TIME=${GPU_TIME:-1}

GPU_BLOCK_ID=${GPU_BLOCK_ID:-""}

# Executa o comando com os valores definidos
./gpu -i "$GPU_BLOCK_ID" -n "$GPU_NAME" -s "$GPU_SIZE" -a "$GPU_ADDRESS" -b "$GPU_BLOCKS" -p "$GPU_PING" -t "$GPU_TIME"

