# Base Image: PyTorch with CUDA 12.4 and cuDNN 9
FROM pytorch/pytorch:2.4.0-cuda12.4-cudnn9-devel

# Set working directory
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && \
    apt-get install -y wget vim git curl && \
    apt-get install -y libgl1 libglib2.0-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the already cloned flux repository from the host machine to the container
COPY ./flux /workspace/flux
COPY ./diffusers /workspace/diffusers



# Set working directory to flux repo
WORKDIR /workspace/flux

# Upgrade pip and install Flux dependencies directly
RUN pip install --upgrade pip && \
    pip install -e ".[all]"

# Install additional Python packages for Jupyter
RUN pip install jupyterlab fastapi uvicorn diffusers matplotlib
RUN pip install --upgrade transformers torchvision gradio
RUN pip install --upgrade git+https://github.com/huggingface/diffusers.git


WORKDIR /workspace/diffusers
RUN pip uninstall diffusers -y  
RUN pip install -e .


# Validate CUDA and PyTorch
RUN python -c "import torch; print('CUDA Available:', torch.cuda.is_available())"

# Expose ports for JupyterLab and FastAPI
EXPOSE 8888
EXPOSE 8000
EXPOSE 2345
EXPOSE 7860

WORKDIR /workspace

# Set the default command to run JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
