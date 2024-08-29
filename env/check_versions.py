import torch
import dgl
print(f"PyTorch version: {torch.__version__}")
print(f"DGL version: {dgl.__version__}")
print(f"CUDA available: {torch.cuda.is_available()}")
print(f"DGL CUDA version: {dgl.backend.backend_name}")