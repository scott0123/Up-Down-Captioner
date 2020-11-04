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

4. Install the python modules (no `sudo` here!)
    ```Shell
    bash install_mods.sh
    ```

5.  Add the environment variables (need to do this for every new shell)
    ```Shell
    source env_vars.sh
    ```

### Other installation (Not needed for demo)
    
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

