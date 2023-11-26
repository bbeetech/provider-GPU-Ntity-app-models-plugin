#!/bin/bash

# Function to check if conda is installed and return the path
function find_conda() {
    which conda || return 1
    return 0
}

# Function to install conda if it's not installed
function install_conda() {
    echo "Conda not found, installing now."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
    bash miniconda.sh -b -p $HOME/miniconda
    export PATH="$HOME/miniconda/bin:$PATH"
    # Initialize conda for current shell
    eval "$($HOME/miniconda/bin/conda shell.bash hook)"
    conda init
    echo "Conda installed."
}

# Download the code from the GitHub repository
function clone_fooocus() {
    if [ ! -d "fooocus-main" ]; then
        echo "Downloading Fooocus from GitHub."
        git clone https://github.com/lllyasviel/Fooocus.git fooocus-main
        echo "Download completed."
    else
        echo "Fooocus directory already exists."
    fi
}


# Check if conda is installed, if not then install it
if ! find_conda; then
    install_conda
fi

# Ensure conda is on the PATH
export PATH="$HOME/miniconda/bin:$PATH"
eval "$(conda 'shell.bash' 'hook')"

# Clone the Fooocus repository
clone_fooocus

# Navigate to the fooocus-main directory
cd fooocus-main || { echo "Directory fooocus-main not found, exiting."; exit 1; }

# Check if the environment exists and create or update it
conda env list | grep fooocus >/dev/null 2>&1
if [ $? -ne 0 ]; then
    conda env create -f environment.yaml
else
    conda env update -f environment.yaml --prune
fi

# Activate the environment
conda activate fooocus || { echo "Failed to activate conda environment, exiting."; exit 1; }

pip install -r requirements_versions.txt

# Run the Python script
python entry_with_update.py || { echo "Failed to run entry, exiting."; exit 1; }

echo "Setup completed successfully."
