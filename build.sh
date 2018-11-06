#!/bin/bash

# Enable logging
export PACKER_LOG="yes"
export PACKER_LOG_PATH="build_output.log"

packer build stretch.json

if [ $? -eq 0 ]
then

  # Cleanup
  echo "Size before reclaiming free space:"
  du -sh output-stretch/packer-stretch
  echo "Reclaiming free space..."
  time qemu-img convert -c -O qcow2 output-stretch/packer-stretch output-stretch/packer-stretch-shrunk.qcow2
  echo "Size after reclaiming free space:"
  du -sh output-stretch/packer-stretch-shrunk.qcow2
  rm -f output-stretch/packer-stretch

else
    echo "Build failed!"
fi


