curl -sL scott-liu.com/mlsetup.sh | sudo bash
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo dpkg -i nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt update
sudo apt install libnccl2=2.7.8-1+cuda10.2 libnccl-dev=2.7.8-1+cuda10.2
rm nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7_7.6.5.32-1+cuda10.2_amd64.deb
sudo dpkg -i libcudnn7_7.6.5.32-1+cuda10.2_amd64.deb
rm libcudnn7_7.6.5.32-1+cuda10.2_amd64.deb
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7-dev_7.6.5.32-1+cuda10.2_amd64.deb
sudo dpkg -i libcudnn7-dev_7.6.5.32-1+cuda10.2_amd64.deb
rm libcudnn7-dev_7.6.5.32-1+cuda10.2_amd64.deb
