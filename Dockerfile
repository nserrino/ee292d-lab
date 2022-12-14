FROM python:3.8.14

COPY openvino-requirements.txt ./

RUN pip install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir -r openvino-requirements.txt

RUN curl -LO https://dl.k8s.io/release/v1.21.5/bin/linux/amd64/kubectl \
  && mv kubectl /usr/local/bin

RUN wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz \
	&& rm -rf /usr/local/go \
	&& tar -C /usr/local -xzf go1.19.2.linux-amd64.tar.gz

RUN git clone https://github.com/nserrino/ml-cli \
  && cd ml-cli \
  && /usr/local/go/bin/go build -o /usr/local/bin/mlm \
  && chmod +x /usr/local/bin/mlm \
  && cd ~