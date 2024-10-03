#!/bin/bash
# Binder design targeting extracellular residues of CD20 from cd20.pdb
# The target residues are on both chains A and B, specifically:
#   Residues 76, 77, 143-179 (minus 147, 149, 152, 154, 155, 158, 159, 162, 163, 164, 165) in both chains A and B.
# We will design a binder of maximum 80 residues.
# The output path and input pdb are specified (cd20.pdb is used here).
# We're specifying the contig as follows:
#   - Targeting residues 76, 77, and 143-179 (excluding specified residues) on both chain A and chain B
#   - 0-80 residue binder length
# We generate 10 designs.
# Using the default complex-finetuned model.

python ../scripts/run_inference.py \
  inference.output_prefix=output_pdbs/cd20_binder \
  inference.input_pdb=input_pdbs/cd20.pdb \
  'contigmap.contigs=[A76-77/A143-146/A148/A150-151/A153/A156-157/A160-161/A166-179/40-80/0 B76-77/B143-146/B148/B150-151/B153/B156-157/B160-161/B166-179]' \
  contigmap.length=40-80 \
  inference.num_designs=10 \
  inference.ckpt_override_path=../models/Complex_base_ckpt.pt
