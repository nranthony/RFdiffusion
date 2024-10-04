import streamlit as st
import os
import re
from stmol import showmol
import py3Dmol

# Make sure to install the required dependencies:
# pip install streamlit==1.24.0 stmol==0.0.9 py3Dmol==2.0.0.post2

def load_pdb_file(file_path):
    with open(file_path, 'r') as f:
        return f.read()

def display_molecule(pdb_str):
    view = py3Dmol.view(width=800, height=500)
    view.addModel(pdb_str, 'pdb')
    view.setStyle({'cartoon': {'colorscheme': 'spectrum'}})
    view.zoomTo()
    return view

st.title("PDB File Viewer using stmol")

folder_path = st.text_input("Enter the path to the folder containing PDB files:",
                            "/home/nelly/repo/nranthony/RFdiffusion/bits2binders_scripts/output_pdbs")

if folder_path and os.path.isdir(folder_path):
    all_pdb_files = [f for f in os.listdir(folder_path) if f.endswith('.pdb')]
    if all_pdb_files:
        # Add regex filter
        regex_filter = st.text_input("Filter PDB files (regex):", ".*")
        try:
            filtered_pdb_files = [f for f in all_pdb_files if re.match(regex_filter, f)]
        except re.error:
            st.error("Invalid regex pattern. Showing all files.")
            filtered_pdb_files = all_pdb_files

        if filtered_pdb_files:
            selected_file = st.selectbox("Select a PDB file to display:", filtered_pdb_files)
        else:
            selected_file = ''
            
        if selected_file:
            file_path = os.path.join(folder_path, selected_file)
            pdb_str = load_pdb_file(file_path)
            
            view = display_molecule(pdb_str)
            st.subheader("Visualization Options")
            color_scheme = st.selectbox("Select color scheme:", 
                                        ["ssJmol","spectrum", "chainbow", "ssPyMOL"])
            view.setStyle({'cartoon': {'colorscheme': color_scheme}})
            if st.checkbox("Add surface representation", True):
                view.addSurface(py3Dmol.VDW, {'opacity': 0.8, 'color': 'white'})

            showmol(view, height=500, width=800)

    else:
        st.warning("No PDB files found in the selected folder.")
else:
    st.warning("Please enter a valid folder path.")

st.sidebar.markdown("""
## About this app

This app uses stmol and py3Dmol to visualize PDB files. 

Features:
- Select and display PDB files from a local folder
- Interactive 3D visualization
- Change color schemes
- Label specific residues
- Add surface representation

For more information, visit [stmol on GitHub](https://github.com/napoles-uach/stmol).
""")
