FROM jupyter/scipy-notebook

LABEL maintainer="Theo Naunheim <theonaunheim@gmail.com"

# Back to jovyan
# Fun fact: https://github.com/jupyter/docker-stacks/issues/358
# Jovian=lives on Jupiter
# Jovyan=lives on Jupyter
USER jovyan

# Install pyfair
RUN mkdir /home/jovyan/work/src
WORKDIR /home/jovyan/work/src
RUN git clone --branch dev --single-branch https://github.com/theonaunheim/pyfair.git
WORKDIR /home/jovyan/work/src/pyfair
RUN pip install --no-cache-dir .
RUN rm -rf /home/jovyan/work/src

# Install ipympl for %matplotlib notebook
RUN pip install --no-cache-dir ipympl
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install jupyter-matplotlib

# Flip back to working environment
WORKDIR /home/jovyan/work/

#############################
# Powershell Usage
#############################

## For me to build and push

### docker build -t theonaunheim/pyfair-notebook:latest .
### docker push theonaunheim/pyfair-notebook:latest

## For anyone to pull and run (Windows will warn for working directory)

### docker pull theonaunheim/pyfair-notebook:latest
### docker run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v ${PWD}:/home/jovyan/work theonaunheim/pyfair-notebook:latest

#############################
# Bash Usage
#############################

## For anyone to pull and run (PWD wrapped in braces on Powershell, parens in Bash)

### docker pull theonaunheim/pyfair-notebook:latest
### docker run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v $(PWD):/home/jovyan/work theonaunheim/pyfair-notebook:latest
