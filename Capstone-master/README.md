# Skin Lesions Classification with Deep Convolutional Neural Network

This Project aims at Skin Lesions Classification using Deep Learning and make an app in flutter to facilitate the same for general public.

### **Dataset**

---

[**The HAM10000 dataset, a large collection of multi-source dermatoscopic images of common pigmented skin lesions**](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/DBW86T)

---

### **Methodolgy**

EDA analysis of the dataset
Pre Processing
Making Baseline and using pretrained models
Fine tuning
Ensembling the 2 best models
Testing and choosing best one

Creating An App in flutter

## Technical Issue

All Notebooks using Keras 2.2.4 and Tensorflow 1.11. Batch-Norm layer in this version of Keras is implemented in a way that: during training your network will always use the mini-batch statistics either the BN layer is frozen or not; also during inference you will use the previously learned statistics of the frozen BN layers. As a result, if you fine-tune the top layers, their weights will be adjusted to the mean/variance of the new dataset. Nevertheless, during inference they will receive data which are scaled differently because the mean/variance of the original dataset will be used. Consequently, if use Keras's example codes for fine-tuning Inception V3 or any network with batch norm layer, the results will be very bad. Please refer to issue [#9965](https://github.com/keras-team/keras/pull/9965) and [#9214](https://github.com/keras-team/keras/issues/9214). One temporary solution is: 

```python
for layer in pre_trained_model.layers:
    if hasattr(layer, 'moving_mean') and hasattr(layer, 'moving_variance'):
        layer.trainable = True
        K.eval(K.update(layer.moving_mean, K.zeros_like(layer.moving_mean)))
        K.eval(K.update(layer.moving_variance, K.zeros_like(layer.moving_variance)))
    else:
        layer.trainable = False
```

## Results

| Models        | Validation           | Test            |  Depth          | # Params          |
| ------------- |:-------------:| :-------------:| :-------------:| :-------------:|
|   Baseline   | 77.48% |76.54% | 11 layers | 2,124,839 |
|  Fine-tuned VGG16 (from last block)    |  79.82%      |   79.64%  | 23 layers | 14,980,935 |
|  Fine-tuned Inception V3 (from the last 2 inception blocks) |  79.935%   |  79.94% | 315 layers | 22,855,463 |
|  Fine-tuned Inception-ResNet V2 (from the Inception-ResNet-C) | 80.82% | 82.53% | 784 layers | 55,127,271 |
|  Fine-tuned DenseNet 201 (from the last dense block) | **85.8%** | **83.9%**  |  711 layers | 19,309,127 |
|  Fine-tuned Inception V3 (all layers) | 86.92% | 86.826% | _ | _ |
|  Fine-tuned DenseNet 201 (all layers)  | **86.696%** | **87.725%** | _ | _ |
|  Ensemble of fully-fine-tuned Inception V3 and DenseNet 201 | **88.8%** | **88.52%** | _ | _ |

## The Interface
![image](https://user-images.githubusercontent.com/56736017/208181052-930b3354-c965-4646-9f66-30929b7746a1.png)
![image](https://user-images.githubusercontent.com/56736017/208181174-14f4c085-e61f-4aa8-84cf-1ed6ebdd8c11.png)
![image](https://user-images.githubusercontent.com/56736017/208181112-1a406a51-efb8-40d4-afd5-2cdf7758446c.png)

## The Dataset

[The HAM10000 dataset, a large collection of multi-source dermatoscopic images of common pigmented skin lesions](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/DBW86T,)
