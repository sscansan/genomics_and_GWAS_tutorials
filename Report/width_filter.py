import re

with open('output.tex', 'r') as file:
    latex_content = file.read()

# add [width=\linewidth] between \includegraphics and the image
modified_latex_content = re.sub(r'(\\includegraphics)(\{[^}]+\})', r'\1[width=\\linewidth]\2', latex_content)

# add it to the file
with open('output.tex', 'w') as file:
    file.write(modified_latex_content)
