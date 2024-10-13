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

# contigmap misc notes
# 'contigmap.contigs=[A76-77/A143-146/A148-148/A150-151/A153-153/A156-157/A160-161/A166-179/40-80/0 B76-77/B143-146/B148-148/B150-151/B153-153/B156-157/B160-161/B166-179]'

python ../scripts/run_inference.py inference.output_prefix=output_pdbs/cd20_binder_hs01 inference.input_pdb=input_pdbs/cd20ecm.pdb 'contigmap.contigs=[A143-186/0 A73-78/0 B143-186/0 B73-78/0 40-80]' ppi.hotspot_res='[A170,A171,A172,A175,A177,A178,B169]' inference.num_designs=20

"""
Notes:

Hotspots:
A175, B161, B166, B170
A161, A171, A173, A177, A178, B161, B171, B173, B177, B178

hs_01
A170,A171,A172,A175,A177,A178,B169


hsb_02 (colab st1) ./RFdiffusion/run_inference.py inference.output_prefix=outputs/cd20ecm inference.num_designs=16 inference.input_pdb=outputs/cd20ecm/input.pdb diffuser.T=50 ppi.hotspot_res='[A175,B161,B166,B170]' 'contigmap.contigs=[A143-186 A73-78 B143-186 B73-78 61-61]' inference.dump_pdb=True inference.dump_pdb_path='/dev/shm' inference.ckpt_override_path=./RFdiffusion/models/Complex_beta_ckpt.pt

A175, B161, B166, B170

hsb_03 (colab st2) ./RFdiffusion/run_inference.py inference.output_prefix=outputs/cd20ecm_1vz4i inference.num_designs=32 inference.input_pdb=outputs/cd20ecm_1vz4i/input.pdb diffuser.T=50 ppi.hotspot_res='[A161,B161]' 'contigmap.contigs=[A143-186 A73-78 B143-186 B73-78 61-61]' inference.dump_pdb=True inference.dump_pdb_path='/dev/shm' inference.ckpt_override_path=./RFdiffusion/models/Complex_beta_ckpt.pt

hsb_04 (colab) - codes after this run st1r8_ea4io_1vz4i

hsb_05
A145,A161,A166,A174,B77,B156,B161,B174
../scripts/run_inference.py inference.output_prefix=output_pdbs/cd20ecm_hsb_05 inference.num_designs=32 inference.input_pdb=input_pdbs/cd20ecm.pdb diffuser.T=50 ppi.hotspot_res='[A145,A161,A166,A174,B77,B156,B161,B174]' 'contigmap.contigs=[A143-186/0 A73-78/0 B143-186/0 B73-78/0 40-80]' inference.ckpt_override_path=../models/Complex_beta_ckpt.pt


hsb_06 (colab)

A161,A174,A178,B77,B144,B148,B156,B161,B166,B168,B174

hsb_07
A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170
../scripts/run_inference.py inference.output_prefix=output_pdbs/cd20ecm_hsb_07 inference.num_designs=32 inference.input_pdb=input_pdbs/cd20ecm.pdb diffuser.T=50 ppi.hotspot_res='[A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170]' 'contigmap.contigs=[A143-186/0 A73-78/0 B143-186/0 B73-78/0 40-80]' inference.ckpt_override_path=../models/Complex_beta_ckpt.pt

hs_08
A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170
../scripts/run_inference.py inference.output_prefix=output_pdbs/cd20ecm_hs_08 inference.num_designs=32 inference.input_pdb=input_pdbs/cd20ecm.pdb diffuser.T=50 ppi.hotspot_res='[A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170]' 'contigmap.contigs=[A143-186/0 A73-78/0 B143-186/0 B73-78/0 21-42]'

hs_09
A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170
../scripts/run_inference.py inference.output_prefix=output_pdbs/cd20ecm_hs_09 inference.num_designs=32 inference.input_pdb=input_pdbs/cd20ecm.pdb diffuser.T=100 ppi.hotspot_res='[A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170]' 'contigmap.contigs=[A143-186/0 A73-78/0 B143-186/0 B73-78/0 36-42]'

hs_09
A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170
../scripts/run_inference.py inference.output_prefix=output_pdbs/cd20ecm_hs_09 inference.num_designs=32 inference.input_pdb=input_pdbs/cd20ecm.pdb diffuser.T=100 ppi.hotspot_res='[A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170]' 'contigmap.contigs=[A143-186/0 A73-78/0 B143-186/0 B73-78/0 36-42]'

hsb_10
A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170
../scripts/run_inference.py inference.output_prefix=output_pdbs/cd20ecm_hsb_10 inference.num_designs=32 inference.input_pdb=input_pdbs/cd20ecm.pdb diffuser.T=42 ppi.hotspot_res='[A175,A176,B76,B77,B144,B145,B148,B150,B153,B156,B157,B160,B161,B163,B166,B170]' 'contigmap.contigs=[A143-186/0 A73-78/0 B143-186/0 B73-78/0 22-36]' inference.ckpt_override_path=../models/Complex_beta_ckpt.pt

python ../scripts/run_inference.py inference.output_prefix=output_pdbs/cd20_binder inference.input_pdb=input_pdbs/cd20.pdb 'contigmap.contigs=[A45-213/0 B45-213/0 60-80]' inference.num_designs=4

mode: fixed
output: outputs/cd20ecm
contigs: ['A143-186', 'A73-78', 'B143-186', 'B73-78', '72-72']
./RFdiffusion/run_inference.py inference.output_prefix=outputs/cd20ecm inference.num_designs=4 inference.input_pdb=outputs/cd20ecm/input.pdb diffuser.T=50 ppi.hotspot_res='[A161,A171,A173,B177,B178]' 'contigmap.contigs=[A143-186 A73-78 B143-186 B73-78 72-72]' inference.dump_pdb=True inference.dump_pdb_path='/dev/shm'


./RFdiffusion/run_inference.py inference.output_prefix=outputs/cd20ecm inference.num_designs=16 inference.input_pdb=outputs/cd20ecm/input.pdb diffuser.T=50 ppi.hotspot_res='[A161,A171,A173,A177,A178,B161,B171,B173,B177,B178]' 'contigmap.contigs=[A143-186 A73-78 B143-186 B73-78 80-80]' inference.dump_pdb=True inference.dump_pdb_path='/dev/shm' inference.ckpt_override_path=./RFdiffusion/models/Complex_beta_ckpt.pt

"""