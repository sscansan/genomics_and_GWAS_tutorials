At each update of the README.md and figures in the root's Figure/ folder, before the LaTeX build run 

```bash update_figures_output.sh```

to update all the new content to be included in the LaTeX report.
it runs bash+pandoc+python

it removes the ./Report/Figures/* content, then takes the content of the ./Figures/* and copies into ./Report/Figures/, then converts the ./README.md into ./Report/output.tex with pandoc, then uses regular expression within python to reformat the images of the ./Report/output.tex so they can be correctly rendered in LaTeX using the flag [width=\linewidth], which renders the \input{output.tex} 

now the images can be correctly rendered both in the markdown file ![alt-text](path) and in the latex oc \includegraphics[width]{path}
