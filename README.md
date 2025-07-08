# IPFS-boot-react
IPFS-boot React.js starter, see:
+ [IPFS-boot](https://github.com/rhodey/IPFS-boot)

## History
This is a standard react project created using:
```
npm create vite@latest ipfs-boot-react -- --template react
```

What differs is [main.jsx](https://github.com/rhodey/IPFS-boot-react/blob/master/src/main.jsx) knows to unmount and [package.json](https://github.com/rhodey/IPFS-boot-react/blob/master/package.json) has updated build targets

## Build
The aim is reproducible builds so docker is involved
```
docker buildx build --platform=linux/amd64 -t ipfs-boot-react .
docker run --rm -i --platform=linux/amd64 -v ./dist:/root/dist ipfs-boot-react
```

## Pin
+ Follow [Pin docs](https://github.com/rhodey/IPFS-boot#pin) in the parent repo
+ You will get container ipfs-pin and .env
```
cp ../IPFS-boot/.env .
CID=$(docker run --rm -i --platform=linux/amd64 -v ./dist:/root/dist --env-file .env ipfs-pin | grep CIDv1 | cut -c9-)
npx ipfs-boot init https://github.com/user/react123 react123
npx ipfs-boot publish --cid $CID --version v0.0.1 --notes "release notes"
cat versions.json
```

If you have [just](https://github.com/casey/just) command runner
```
cp ../IPFS-boot/.env .
npx ipfs-boot init https://github.com/user/react123 react123
just publish v0.0.1 "release notes"
cat versions.json
```

All that remains is send versions.json to your https server, where the bootloader looks (needs CORS), remember dist/ (your app) is at this point now with IPFS

## Dev
[http://localhost:8080](http://localhost:8080/)
```
npm install
npm run dev
```

## Demo
Please if you want to style the [default bootloader](https://github.com/rhodey/IPFS-boot), open a PR ^.^
+ ipfs://bafybeiguynsoc3zlpc3bvf2c6zdvygelzzzrsozm7uc4ayjrthy6ncqitm
+ https://bafybeiguynsoc3zlpc3bvf2c6zdvygelzzzrsozm7uc4ayjrthy6ncqitm.ipfs.dweb.link

## License
MIT - Copyright 2025 - mike@rhodey.org
