# install basic dependencies
sudo apt-get update
sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install -y --no-install-recommends libboost-all-dev
sudo apt-get install -y libopenblas-dev liblapack-dev libatlas-base-dev
sudo apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev
sudo apt-get install -y python-dev python-pip python-numpy cython

# Build Caffe and pycaffe
export REPO_ROOT=$(pwd)
cd $REPO_ROOT/external/caffe
cp Makefile.config.example Makefile.config
# make edits
sed -i '5s/^# //;21s/^# //;92s/^# //;104s/^# //' Makefile.config
sed -i '95s/$/ \/usr\/include\/hdf5\/serial \/usr\/include\/opencv4 \/usr\/include\/boost/' Makefile.config
sed -i '96s/$/ \/usr\/lib\/x86_64-linux-gnu\/hdf5\/serial/' Makefile.config
sed -i '37,38d' Makefile.config
sed -i '37s/\t/CUDA_ARCH :=/' Makefile.config
sed -i 's/<Dtype, int>//g' src/caffe/layers/beam_search_node_layer.cpp
sed -i 's/<Dtype,int>//g' src/caffe/layers/beam_search_node_layer.cpp
sed -i 's/std::greater<pair >()/std::greater<pair<Dtype,int> >()/g' src/caffe/layers/beam_search_node_layer.cpp
sed -i 's/STUB_GPU_FORWARD(ArgMaxLayer);/STUB_GPU_FORWARD(ArgMaxLayer,Forward);/g' src/caffe/layers/argmax_layer.cpp
sed -i 's/CV_LOAD_IMAGE_COLOR/cv::IMREAD_COLOR/g' src/caffe/layers/window_data_layer.cpp
sed -i -e 's/CV_LOAD_IMAGE_COLOR/cv::IMREAD_COLOR/g' -e 's/CV_LOAD_IMAGE_GRAYSCALE/cv::IMREAD_GRAYSCALE/g' src/caffe/util/io.cpp
# Build
make -j8 && make pycaffe

# Build COCO
cd $REPO_ROOT/external/coco/PythonAPI
make

# Build the Cython modules
cd $REPO_ROOT/lib
make

# install python2 modules
python2 -m pip install --upgrade pip
pip2 install jupyter ipython matplotlib scikit-image protobuf easydict opencv-python==4.2.0.32 pyyaml
python2 -m ipykernel install --user
