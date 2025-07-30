# Why Use the FLUX Model with Extended Mask and Reference Image Capabilities

## 1. Introduction

To check the general problem overview, refer to the file [flux_extended.md](../experimentation/flux_extended.md)

This section focuses on the **price–inference speed analysis**. You can check the experiment in this notebook:  
[exp_flux_extended.ipynb](exp_flux_extended.ipynb)

Using the default `num_inference_steps=40` with the **Flux Kontext Extended** model, inference takes approximately **20.4 seconds**, with a peak GPU memory usage of **36,569 MiB**.  
The **H100 GPU** has a maximum memory of **81,559 MiB**, meaning each inference uses about **44.9%** of the available memory.  
Thus, **2 inference pods** can be run per H100 GPU.

Given that a node has **8×H100 GPUs**, up to **16 inference pods** can run simultaneously.

If one hour of an H100.8 node costs **80 USD**, the cost per image editing operation is:

- **Cost for 20.4 seconds** = 0.4533 USD for 16 images  
- **Cost per image** = 0.4533 / 16 = **0.0283 USD**

---

### Hypothesis: H200 (to be tested)

- **GPU memory**: 140 GB  
- Up to **3 pods** per GPU → **24 pods per node (8×H200)**  
- **Cost for 20.4 seconds** = 0.4533 USD for 24 images  
- **Cost per image** = 0.4533 / 24 = **0.0183 USD**

---

### Hypothesis: B200 (to be tested)

- **GPU memory**: 180 GB  
- Up to **4 pods** per GPU → **32 pods per node (8×B200)**  
- **Cost for 20.4 seconds** = 0.4533 USD for 32 images  
- **Cost per image** = 0.4533 / 32 = **0.0143 USD**

---

## 5. References

* [FLUX with Mask and Reference Images (Pull Request)](https://github.com/huggingface/diffusers/pull/11820)
* [FLUX Model GitHub Repository](https://github.com/black-forest-labs/flux)
* [FLUX.1-Fill-dev Model (used in ACE Plus)](https://huggingface.co/black-forest-labs/FLUX.1-Fill-dev)
* [Flux Kontext Documentation – Image Editing](https://github.com/black-forest-labs/flux/blob/main/docs/image-editing.md)
