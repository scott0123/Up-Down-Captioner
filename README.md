# Up-Down-Captioner

### Source
See the [original repo](https://github.com/peteanderson80/Up-Down-Captioner) for more information on [Introduction/Reference/License/Requirements/Results].

### Installation

1.  Clone the Up-Down-Captioner repository:
    ```Shell
    # Make sure to clone with --recursive
    git clone --recursive https://github.com/scott0123/Up-Down-Captioner.git
    ```

2.  (If starting without CUDA/NCCL/CUDNN installed) Install the ML environment:
    ```Shell
    sudo bash ml_env.sh
    ```

3.  Build the dependencies
    ```Shell
    sudo bash build_dep.sh
    ```

4.  Add the environment variables (need to do this for every new shell)
    ```Shell
    source env_vars.sh
    ```

### Other installation
    
6.  Download Stanford CoreNLP (required by the evaluation code):
    ```Shell
    cd ./external/coco-caption
    ./get_stanford_models.sh
    ```

7.  Download the MS COCO train/val image caption annotations. Extract all the json files into one folder `$COCOdata`, then create a symlink to this location:
    ```Shell
    cd $REPO_ROOT/data
    ln -s $COCOdata coco
    ``` 

8.  Pre-process the caption annotations for training (building vocabs etc).
    ```Shell
    cd $REPO_ROOT
    python scripts/preprocess_coco.py
    ``` 
    
8.  Download or generate pretrained image features following the instructions below.


### Pretrained image features

**LINKS HAVE BEEN UPDATED**

The captioner takes pretrained image features as input (and does not finetune). For best performance, bottom-up attention features should be used. Code for generating these features can be found [here](https://github.com/peteanderson80/bottom-up-attention). For ease-of-use, we provide pretrained features for the [MSCOCO dataset](http://mscoco.org/dataset/#download). Manually download the following tsv file and unzip to `data/tsv/`:
- [2014 Train/Val Image Features (120K / 23GB)](https://imagecaption.blob.core.windows.net/imagecaption/trainval.zip)

To make a test server submission, you would also need these features:
- [2014 Testing Image Features (40K / 7.3GB)](https://imagecaption.blob.core.windows.net/imagecaption/test2014.zip)

Alternatively, to generate conventional pretrained features from the ResNet-101 CNN:
- Download the [pretrained ResNet-101 model](https://github.com/KaimingHe/deep-residual-networks#models) and save it in `baseline/ResNet-101-model.caffemodel`
- Download the MS COCO train/val images, and extract them into `data/images`.
- Run:
```Shell
cd $REPO_ROOT
./scripts/generate_baseline.py
``` 

### Training

To train the model on the karpathy training set, and then generate and evaluate captions on the karpathy testing set (using bottom-up attention features): 
```Shell
cd $REPO_ROOT
./experiments/caption_lstm/train.sh
```

Trained snapshots are saved under: `snapshots/caption_lstm/`

Logging outputs are saved under: `logs/caption_lstm/`

Generated caption outputs are saved under: `outputs/caption_lstm/`

Scores for the generated captions (on the karpathy test set) are saved under: `scores/caption_lstm/`

To train and evaluate the baseline using conventional pretrained features, follow the instructions above but replace `caption_lstm` with `caption_lstm_baseline_resnet`.

### Results

Results (using bottom-up attention features) should be similar to the numbers below (as reported in Table 1 of the paper).

|                   | BLEU-1  | BLEU-4  | METEOR  | ROUGE-L |  CIDEr  |  SPICE  |
|-------------------|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|
|Cross-Entropy Loss |  77.2   |  36.2   |  27.0   |  56.4   |  113.5  |  20.3   |
|CIDEr Optimization |  79.8   |  36.3   |  27.7   |  56.9   |  120.1  |  21.4   |

### Other useful scripts

1. `scripts/create_caption_lstm.py`
    The version of caffe provided as a submodule with this repo includes (amongst other things) a custom `LSTMNode` layer that enables sampling and beam search through LSTM layers. However, the resulting network architecture prototxt files are quite complicated. The file `scripts/create_caption_lstm.py` scaffolds out network structures, such as those in `experiments`.

2. `layers/efficient_rcnn_layers.py`
    The provided `net.prototxt` file uses a python data layer (`layers/rcnn_layers.py`) that loads all training data (including image features) into memory. If you have insufficient system memory use this python data layer instead, by replacing `module: "rcnn_layers"` with `module: "efficient_rcnn_layers"` in `experiments/caption_lstm/net.prototxt`.

3. `scripts/plot.py`
    Basic script for plotting validation set scores during training.
