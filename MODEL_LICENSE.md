# Model License & Provenance

This document covers the **machine-learning model artifact** in this repository. It is licensed
**separately** from the source code.

| Artifact | Path |
|---|---|
| Core ML model (float) | `Sources/PixelBlurDetectorKit/BlurSegmentation.mlpackage` |

> The **source code** in this repository is licensed under **Apache-2.0** (see
> [`LICENSE`](LICENSE)). The Apache-2.0 license does **not** apply to the model artifact listed
> above.

## Training data

The model was trained on three academic datasets:

1. **CUHK Blur Detection Dataset**
   (J. Shi, L. Xu, J. Jia, *"Discriminative Blur Detection Features"*, CVPR 2014)
   <http://www.cse.cuhk.edu.hk/~leojia/projects/dblurdetect/dataset.html>
2. **DUT-DBD Dataset**
   (W. Zhao, F. Zhao, D. Wang, H. Lu, *"Defocus Blur Detection via Multi-stream Bottom-Top-Bottom
   Fully Convolutional Network"*, CVPR 2018)
   <https://openaccess.thecvf.com/content_cvpr_2018/html/Zhao_Defocus_Blur_Detection_CVPR_2018_paper.html>
3. **EBD Dataset**
   (Y. Jin, M. Qian, J. Xiong, N. Xue, G.-S. Xia, *"Depth and DOF Cues Make A Better Defocus Blur
   Detector"*, ICME 2023)
   <https://github.com/yuxinjin-whu/D-DFFNet>

> **Correction (October 2026):** earlier versions of this document listed only CUHK and DUT-DBD.
> The training data also included EBD, which was left out by mistake.

## Current status: license unclear, non-commercial for now ⚠️

**None of the three datasets states a license.** As of October 2026:

- The CUHK dataset page describes the data and links the downloads, but gives no license, terms of
  use or statement about commercial use.
- The original DUT-DBD project page (`ice.dlut.edu.cn/ZhaoWenda/BTBCRLNet.html`) is no longer
  reachable, and no license for the dataset has been found elsewhere.
- The EBD dataset is distributed through the authors' code repository, which describes it as a
  test set and gives no license for the dataset or the code.

Without a license, we can't confirm that commercial use of these datasets, or of models trained on
them, is allowed. Whether trained model weights are a derivative work of their training data is
also legally unsettled. Until this is resolved:

- The model artifact is offered for **research and non-commercial use only**.
- **Do not ship it in a commercial or closed-source application.**
- If you want to use it commercially, **contact the authors of all three datasets first.**
  Permission for one or two of them is not enough, because the model was trained on all three.

This is a conservative, good-faith position, **not legal advice**.

## Making the model commercially usable

One of the following must happen first:

1. **Get written permission** from the authors of **all three** datasets (CUHK, DUT-DBD and EBD) for
   commercial use of models trained on them, and record it here (and in `NOTICE`).
2. **Retrain** the model on data whose license allows commercial use (or on self-collected data),
   and replace the artifact above.

Until then, only the **Apache-2.0 source code** can be reused commercially, not the bundled model.

## Test images (CC0)

The test images (`Tests/PixelBlurDetectorKitTests/resources/cc0_*`) are **CC0 / public-domain**
images from Wikimedia Commons, not images from the datasets above; see the License section of the
[README](README.md#license). The datasets affect **only the trained model weights**.
