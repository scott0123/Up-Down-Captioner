curl -sL scott-liu.com/mlsetup.sh | sudo bash
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo dpkg -i nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt update
sudo apt install libnccl2=2.7.8-1+cuda10.2 libnccl-dev=2.7.8-1+cuda10.2
rm nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn8_8.0.4.30-1+cuda10.2_amd64.deb
sudo dpkg -i libcudnn8_8.0.4.30-1+cuda10.2_amd64.deb
rm libcudnn8_8.0.4.30-1+cuda10.2_amd64.deb
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn8-dev_8.0.4.30-1+cuda10.2_amd64.deb
sudo dpkg -i libcudnn8-dev_8.0.4.30-1+cuda10.2_amd64.deb
rm libcudnn8-dev_8.0.4.30-1+cuda10.2_amd64.deb
