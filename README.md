# IPFS-boot-react
IPFS-boot React.js starter, see:
+ [IPFS-boot](https://github.com/rhodey/IPFS-boot)

## History
This is a standard react project created using:
```
npm create vite@latest ipfs-boot-react -- --template react
```

What differs is [main.jsx](/src/main.jsx) knows to unmount and [package.json](/package.json) has updated build targets

## Build
The aim is reproducible builds so docker is involved
```
docker buildx build --platform=linux/amd64 -t ipfs-boot-react .
docker run --rm -i --platform=linux/amd64 -v ./dist:/root/dist ipfs-boot-react
> CIDv1 = bafybeih6ahjvidh6r7se5asm2zf53kkpqrhj5phw2mfcx7jdz4uoozj5ja
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
These CIDs are IPFS-boot, when selecting an app version you will see CIDv1 from above
+ ipfs://bafybeifehbm2um54qvfifprtbkgbt25ndkq6k26zjlbe33t2j62gdjwn2m
+ https://bafybeifehbm2um54qvfifprtbkgbt25ndkq6k26zjlbe33t2j62gdjwn2m.ipfs.dweb.link

## License
MIT
