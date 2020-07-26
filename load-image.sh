#!/bin/bash

# 配置镜像
image="gcr.io/kubernetes-helm/tiller:v2.16.7"
name="tiller.v2.16.7"

# =========不需要调整===========  #
image_tar="$name.tar.gz"
harbor="harbor.deepexi.cloud/library"
# ====================  #

tag_image="$harbor/tiller:v2.16.7"

# 下载压缩包
./ossutilmac64 cp oss://oss4image/$image_tar .   
gunzip -c $image_tar | docker load

# # 推送到harbor

# # docker login harbor.deepexi.cloud -u wukunpeng -p Abcd1234
docker tag $image $tag_image
docker push $tag_image

## 验证是否上传成功
docker pull $tag_image

# 清理资源
rm $image_tar
docker rmi $tag_image
docker rmi $image

