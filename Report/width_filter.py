import re

# Read the LaTeX file
with open('output.tex', 'r') as file:
    latex_content = file.read()

# Add [width=\linewidth] between \includegraphics and the image path
modified_latex_content = re.sub(r'(\\includegraphics)(\{[^}]+\})', r'\1[width=\\linewidth]\2', latex_content)

# Write the modified LaTeX content back to the file
with open('output.tex', 'w') as file:
    file.write(modified_latex_content)
