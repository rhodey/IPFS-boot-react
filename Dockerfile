FROM ubuntu:24.04

RUN apt update
RUN apt install -y curl git

# install node
WORKDIR /root/js
ENV NVM_DIR=/root/js/.nvm
RUN git clone --depth 1 --branch v0.40.1 https://github.com/nvm-sh/nvm nvm
RUN cd nvm && . ./nvm.sh && nvm install 20.11.1
ENV PATH="/root/js/.nvm/versions/node/v20.11.1/bin:$PATH"
RUN node -v

# install ipfs cli
WORKDIR /root/ipfs
RUN curl https://dist.ipfs.tech/kubo/v0.32.0/kubo_v0.32.0_linux-amd64.tar.gz -o kubo_v0.32.0_linux-amd64.tar.gz
RUN tar -xvzf kubo_v0.32.0_linux-amd64.tar.gz
RUN cd kubo && bash -c "./install.sh"

# js packages
WORKDIR /root/js
COPY package.json .
COPY package-lock.json .
RUN npm install

# sources
WORKDIR /root/js
COPY src/ src/
COPY public/ public/
COPY index.html .
COPY eslint.config.js .
COPY vite.config.js .

COPY <<EOF /root/cmd.sh
# build
npm run build
rm -rf /root/dist/*
cp -r dist/* /root/dist
# show CID
ipfs init >>/dev/null 2>&1
cid=\$(ipfs add -q -r /root/dist | tail -n 1)
echo "CIDv0 = \$cid"
cb32=\$(ipfs cid base32 "\$cid")
echo "CIDv1 = \$cb32"
EOF

RUN chmod +x /root/cmd.sh
CMD ["bash", "-c", "/root/cmd.sh"]
