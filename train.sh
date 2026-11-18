```bash
#!/bin/bash

# Datapath
DATA_DIR="./datasets/SH17"
MODEL="yolov9n.pt" # Choose model
EPOCHS=100
BATCH=16
IMGSZ=640
DEVICE=0

pip install -U ultralytics pyyaml

# Create file config yaml
cat <<EOF > sh17.yaml
path: $DATA_DIR
train: train/images
val: val/images

names:
  0: person
  1: head
  2: face
  3: glasses
  4: face-mask-medical
  5: face-guard
  6: ear
  7: earmuffs
  8: hands
  9: gloves
  10: foot
  11: shoes
  12: safety-vest
  13: tools
  14: helmet
  15: medical-suit
  16: safety-suit
EOF

# Run train
yolo detect train \
    model=$MODEL \
    data=sh17.yaml \
    epochs=$EPOCHS \
    imgsz=$IMGSZ \
    batch=$BATCH \
    device=$DEVICE \
    project=SH17_Benchmark \
    name=yolov9t_run \
    exist_ok=True

# Zip the result
zip -r yolov9t_sh17.zip SH17_Benchmark/yolov9_run