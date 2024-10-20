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
GPU_SIZE=${GPU_SIZE:-100000000000}

GPU_ADDRESS=${GPU_ADDRESS:-RTX-4090}

GPU_BLOCKS=${GPU_BLOCKS:-3000}

# Executa o comando com os valores definidos
./gpu --name="$GPU_NAME" --size="$GPU_SIZE" --address="$GPU_ADDRESS" --blocks="$GPU_BLOCKS"
