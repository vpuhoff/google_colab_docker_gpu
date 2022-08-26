FROM nvcr.io/nvidia/pytorch:21.05-py3
ENV DEBIAN_FRONTEND noninteractive

RUN conda install -c main jupyter pandas  pip
RUN conda create --name cuda_env

RUN apt update && apt-get install python3-dev libpython3.8-dev ffmpeg libsm6 libxext6 -y 

COPY req.txt req.txt
RUN --mount=type=cache,mode=0755,target=/root/.cache/pip pip install -r req.txt

RUN --mount=type=cache,mode=0755,target=/root/.cache/pip pip install google-colab==1.0.0 --no-deps

COPY req_custom.txt req_custom.txt
RUN --mount=type=cache,mode=0755,target=/root/.cache/pip  /opt/conda/bin/pip install -r req_custom.txt


EXPOSE 8888
ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--port=8888","--allow-root"]
