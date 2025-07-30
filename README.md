# Flux Model Experimentation

This document provides a guide for experimenting with the Flux model. 

## Clone the Repository

To get started, clone the official FLUX model repository:

```bash
git clone https://github.com/black-forest-labs/flux
```

Next, to enable extended inpainting capabilities (such as mask and reference image support), you'll need to download and install the pull request specified in the  
[official PR documentation](https://github.com/huggingface/diffusers/pull/11820):

```bash
git clone https://github.com/huggingface/diffusers.git
cd diffusers
git fetch origin pull/11820/head:feature/inpaint-kontext
git checkout feature/inpaint-kontext
```

## Create the Docker image

Build the Docker image for the Flux experimentation:

```bash
docker build -t flux-extended .
```

## Run the Docker container

Run the Docker container with the required ports and volumes:

```bash
sudo docker run --rm -it --gpus all --ipc=host \
  -p 8888:8888 \
  -v ./flux:/workspace/flux \
  -v ./experimentation:/workspace/experimentation \
  -v ./experimentation_optimization:/workspace/experimentation_optimization \
  flux-extended
```

## Log in to Hugging Face

1. Open another terminal and enter the Docker container:

```bash
docker ps
docker exec -it <container_id> bash
```

2. Inside the Docker container , log into Hugging Face using the CLI:
You need this in order to download the model 

```bash
huggingface-cli login
```

## Run the Jupyter Experiment

Refer to the file [flux_extended.md](experimentation/flux_extended.md)  and to the notebook [exp_flux_extended.ipynb](experimentation/exp_flux_extended.ipynb) for details on the experimental context demonstrating how FLUX’s extended inpainting capabilities provide improved control over banner editing.


## References
- [Flux with mask and reference images](https://github.com/huggingface/diffusers/pull/11820)
- [Flux Model GitHub Repository](https://github.com/black-forest-labs/flux)
- This [FLUX.1-Fill-dev model](https://huggingface.co/black-forest-labs/FLUX.1-Fill-dev) is also used in ACE Plus
- [Flux Kontext Documentation - Image Editing](https://github.com/black-forest-labs/flux/blob/main/docs/image-editing.md)


